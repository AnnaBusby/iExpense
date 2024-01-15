//
//  ContentView.swift
//  iExpense
//
//  Created by Anna Busby on 21/12/2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem] () {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                Spacer()
                                
                                Text(item.amount, format: .currency(code:  Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(styling(item: item))
                                
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                Spacer()
                                
                                Text(item.amount, format: .currency(code:  Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(styling(item: item))
                                
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }

            }
            
            
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink("\(Image(systemName: "plus"))", destination: AddView(expenses: expenses))
            }
        }
        
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
        
    }
    
    func styling(item: ExpenseItem) -> Color {
        if item.amount < 10 {
            return .green
        } else if item.amount > 100 {
            return .red
        } else {
            return .black
        }
    }
    
}

#Preview {
    ContentView()
}
