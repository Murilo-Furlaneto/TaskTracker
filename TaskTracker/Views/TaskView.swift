//
//  TaskView.swift
//  TaskTracker
//
//  Created by murilo furlaneto on 19/11/26.
//

import SwiftUI
import SwiftData

struct Taskview : View {
    @State private var taskCount: Int = 0
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    
    @State private var newTaskTitle = ""
    
    var body: some View {
        VStack {
            Text("Task Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            
            
            HStack {
                TextField("New Task", text: $newTaskTitle)
                    .textFieldStyle(.roundedBorder)
                Button("Add") {
                    addTask()
                }
                .buttonStyle(.borderedProminent)
                .disabled(newTaskTitle.isEmpty)
                
            }
            
            List {
                ForEach(tasks) {
                    task in
                    HStack {
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                        Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "circlebadge")
                    }
                    .onTapGesture {
                        toggleTask(task: task)
                    }
                }
                .onDelete(perform: deleteTask)
            }
        }
    }
    
    private func addTask(){
        let newTask = Task(title: newTaskTitle)
        modelContext.insert(newTask)//save it to the database
        newTaskTitle = ""
    }
    
    private func toggleTask(task:Task) {
        task.isCompleted.toggle()
        
    }
    
    //Delets the task by swiping left
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
}


#Preview {
    Taskview()
}
