//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by 김정민 on 2021/05/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // sort 방식은 sortDescriptors 안에서 정한다
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)])
    private var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    Text(task.title ?? "Untitled")
                        .onTapGesture(count: 1) {
                            updateTask(task)
                        }
                }.onDelete(perform: deleteTasks)
            }
            .navigationTitle("Todo List")
            .navigationBarItems(trailing: Button("Add Task") {
               addTask()
            })
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    private func updateTask(_ task: FetchedResults<Task>.Element) {
        withAnimation {
            task.title = "Updated"
            saveContext()
        }
    }
    
    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func addTask() {
        withAnimation {
            let newTask = Task(context: viewContext)
            newTask.title = "New Task \(Date())"
            newTask.date = Date()
            
            saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
