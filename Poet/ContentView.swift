//
//  ContentView.swift
//  Poet
//
//  Created by Eetu Eskelinen on 22.11.2022.
//

import SwiftUI
import ConfettiSwiftUI


struct Task: Hashable, Identifiable, Codable {
    var id = UUID()
    var title: String
    var completed = false
}

struct TaskRow: View {
    @State var task: Task
    @State private var hovered = false
    @StateObject private var store = TaskStore();
    
    var body: some View {
        Button{
            withAnimation(.easeInOut(duration: 0.2)) {
                task.completed.toggle()
                store.updateTask(task: task)
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
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background( hovered ? RoundedRectangle(cornerRadius: 5).fill(.secondary.opacity(0.1)) : nil)
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.1), value: hovered)
        .onHover { isHovered in
            self.hovered = isHovered
        }
    }
}

struct ContentView: View {
    @StateObject private var store = TaskStore()
    @State private var todoInput: String = ""
    @FocusState private var todoInputIsFocused: Bool
    //    @State var tasks: [Task] = [
    //        Task(title: "Here's to the crazy ones"),
    //        Task(title: "Another task", completed: true),
    //        Task(title: "A long task name that will  need to be rendered on separate rows")
    //    ]
    @State private var allTasksCompleted: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Populate list with todos
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(store.tasks, id: \.id) { task in
                        TaskRow(task: task)
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
                    if (!todoInput.isEmpty) {
                        print("Added \(todoInput) to tasks")
                        store.tasks.append(Task(title: "\(todoInput)"))
                        store.save()
                        todoInput = ""
                        print("tasks count is ", store.tasks.count)
                    }
                }
                Button {
                    print("Deleting")
                    store.clear()
                } label: {
                    HStack {
                        Image(systemName: "trash")
                    }
                }
            }
            .padding()
            .confettiCannon(counter: $store.allCompleted)
        }
        .frame(width: 300, height: 300)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
