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
    var lastName = "Baggin"
}

struct Practice: View {
    
    @State private var user = User()
    
    var body: some View {
        Text("Hello, your name is \(user.firstName) \(user.lastName)")
        
        TextField("Enter first name:", text: $user.firstName)
        TextField("Enter last name:", text: $user.lastName)
    }
}

#Preview {
    Practice()
}
