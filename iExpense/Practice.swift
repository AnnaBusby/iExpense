//
//  Practice.swift
//  iExpense
//
//  Created by Anna Busby on 21/12/2023.
//
// This is for project 7 day 36
// showing different sheets and dismissing them - .sheet, isPresented
// watching for state changes in a class vs a struct - @Observable
// adding and deleting rows in a list - @Enviroment, .toolbar edit
//storing user data using @AppStorage or UserDefaults.Set

import SwiftUI

//This makes the class watch for changes to the variables inside the class
@Observable
class User {
   var firstName = "Bilbo"
    var lastName = "Baggins"
}

//Codable allows Swift to create and archive the struct
struct UserStruct: Codable {
    var firstName: String
    var lastName: String
}

struct Practice: View {
    
    //here is one way to store user data
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    //Here is another way to store user data
    @AppStorage ("Tap2") private var tapCount2 = 0
    
    @State private var user = User()
    
    @State private var isShowing = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            
            //store this data under the key Tap
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
        
        //this one will automatically store it
        Button("Tap count 2: \(tapCount2)") {
            tapCount2 += 1
            
        }
        
        Spacer()
        
        Text("Hello, your name is \(user.firstName) \(user.lastName)")
        
        TextField("Enter first name:", text: $user.firstName)
        TextField("Enter last name:", text: $user.lastName)
        
        Button("Show next sheet") {
            isShowing.toggle()
        }
        //when the $isShowing var is true then show a new sheet
        .sheet(isPresented: $isShowing) {
            //This is the sheet/view to show, and weve passed it some paramenters from the current view
            Practice2(name: "\(user.firstName) \(user.lastName)")
        }
        
        //This next bit is focusing on creating rows and deleting them
        NavigationStack{
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    //when we swipe to delete run the function remove rows, which will delete the selected row from view and also from the numbers array
                    .onDelete(perform: removeRows)
                }
                
                
                Button("Add new number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
        
}
   

struct Practice2: View {
    //This allows the user to dismis the current view depending on how it was created
    @Environment(\.dismiss) var dismiss
    
    var name: String
    
    @State private var testUser = UserStruct(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        Text("Hello \(name)")
        
        //This button initates the dismiss action
        Button ("Goodbye") {
            dismiss()
        }
        
        //This button creates and stores user data,
        Button ("Save test user") {
            let encoder = JSONEncoder()
            //you can also use decoder
            
            if let data = try? encoder.encode(testUser) {
                UserDefaults.standard.set(data, forKey: "UserDate")
            }
        }
    }
    
}


#Preview {
    Practice()
}
