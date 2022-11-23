//
//  ContentView.swift
//  Poet
//
//  Created by Eetu Eskelinen on 22.11.2022.
//

import SwiftUI


struct ContentView: View {
    
    @State private var todoInput: String = ""
    @FocusState private var todoInputIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
//           // Populate list with todos
//            List() { todo in
//            HStack(alignment: .center) {
//
//            }
                
//        }
            TextField(
                "Todo",
                text: $todoInput
            )
            .focused($todoInputIsFocused)
            .disableAutocorrection(true)
            .onSubmit {
                print("Submitted")
                todoInput = ""
            }
        }
        .padding()
        .frame(width: 300, height: 300)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
