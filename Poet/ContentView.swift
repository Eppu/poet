//
//  ContentView.swift
//  Poet
//
//  Created by Eetu Eskelinen on 22.11.2022.
//

import SwiftUI


struct Task: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var completed = false
}

struct TaskView: View {
    @State var task: Task
    
    var body: some View {
        Button(action: { task.completed.toggle() }) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Image(systemName: task.completed ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.secondary)
                Text(task.title)
                    .strikethrough(task.completed)
                    .foregroundColor(task.completed ? .secondary : .primary)
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
        if(task.completed) {
            //            Button(action: { tasks.filter() {$0.id != task.id}})
        }
    }
}

struct ContentView: View {
    // TODO: Add AppStorage for persisting task state
    @State private var todoInput: String = ""
    @FocusState private var todoInputIsFocused: Bool
    @State var tasks: [Task] = [
        Task(title: "Here's to the crazy ones"),
        Task(title: "Another task"),
        Task(title: "A long task name that will  need to be rendered on separate rows")
    ]
    
    
    var body: some View {
        VStack(alignment: .leading) {
            //            Image(systemName: "globe")
            //                .imageScale(.large)
            //                .foregroundColor(.accentColor)
            //            Text("Things to get done").font(Font.headline).bold()
            
            // Populate list with todos
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(tasks, id: \.id) { task in
                        TaskView(task: task)
                    }
                }
            }.padding(.top, 5)
            
            
            
            
            TextField(
                "What do you need to get done?",
                text: $todoInput
            )
            .focused($todoInputIsFocused)
            .disableAutocorrection(true)
            .onSubmit {
                print("Added \(todoInput) to tasks")
                tasks.append(Task(title: "\(todoInput)"))
                todoInput = ""
                print("tasks count is ", tasks.count)
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
