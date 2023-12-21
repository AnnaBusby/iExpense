//
//  Practice.swift
//  iExpense
//
//  Created by Anna Busby on 21/12/2023.
//

import SwiftUI

@Observable
class User {
   var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct Practice: View {
    
    @State private var user = User()
    
    @State private var isShowing = false
    
    var body: some View {
        Text("Hello, your name is \(user.firstName) \(user.lastName)")
        
        TextField("Enter first name:", text: $user.firstName)
        TextField("Enter last name:", text: $user.lastName)
        
        Button("Show next sheet") {
            isShowing.toggle()
        }
        .sheet(isPresented: $isShowing) {
            Practice2(name: "\(user.firstName) \(user.lastName)")
        }
    }
        
}
   

struct Practice2: View {
    @Environment(\.dismiss) var dismiss
    
    var name: String
    
    var body: some View {
        Text("Hello \(name)")
        Button ("Goodbye") {
            dismiss()
        }
    }
    
}
#Preview {
    Practice()
}
