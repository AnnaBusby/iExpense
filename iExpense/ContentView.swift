//
//  ContentView.swift
//  iExpense
//
//  Created by Anna Busby on 21/12/2023.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem] ()
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expsense", systemImage: "plus") {
                    let newExpense = ExpenseItem(name: "test", type: "personal", amount: 5)
                    expenses.items.append(newExpense)
                }
            }
        }
        
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
        
    }
    
}

#Preview {
    ContentView()
}
