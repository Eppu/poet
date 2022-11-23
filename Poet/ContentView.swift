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
    @State private var hovered = false
    
    var body: some View {
        Button{
            withAnimation(.easeInOut(duration: 0.2)) {
                task.completed.toggle()
            }
            
        } label: {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Image(systemName: task.completed ? "largecircle.fill.circle" : "circle")
                    .foregroundColor( task.completed ? .secondary : .primary )
                Text(task.title)
                    .strikethrough(task.completed)
                    .foregroundColor(task.completed ? .secondary : .primary)
                    .scaleEffect(task.completed ? 0.96 : 1, anchor: .leading )
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.vertical, 5)
        .background( hovered ? RoundedRectangle(cornerRadius: 5).fill(.secondary.opacity(0.1)) : nil)
        .animation(.easeInOut(duration: 0.1), value: hovered)
        .onHover { isHovered in
            self.hovered = isHovered
        }
        
        
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
        Task(title: "Another task", completed: true),
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
                VStack(alignment: .leading) {
                    ForEach(tasks, id: \.id) { task in
                        TaskView(task: task)
                    }
                }
            }.padding(.top, 5)
            
            
            
            HStack() {
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
                Button {
                    print("Deleting")
                } label: {
                    HStack {
                        Image(systemName: "trash")
                    }
                }
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
