//
//  TaskStore.swift
//  Poet
//
//  Created by Eetu Eskelinen on 24.11.2022.
//

import Foundation

class TaskStore: ObservableObject {
    @Published var tasks = [Task]()
    @Published var allCompleted: Int = 0
    
    init() {
        load()
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: "tasks"),
              let savedTasks = try? JSONDecoder().decode([Task].self, from: data) else { tasks = []; return }
        
        tasks = savedTasks
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "tasks")
            
            if (self.tasks.allSatisfy(\.completed)) {
                allCompleted = 1
            }
        } catch {
            print(error)
        }
    }
    
    func clear() {
        tasks.removeAll()
        save()
    }
}
