//
//  TasksView.swift
//  ToDoList
//
//  Created by Mirza Baig on 01/10/22.
//

import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    
    init(){
        UITableView.appearance().backgroundColor = .red
    }
    
    var body: some View {
        VStack{
            Text("My Task")
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            List{
                ForEach(realmManager.tasks, id:\.id) { task in
                    if !task.isInvalidated {
                        TaskRow(task: task.title, completed: task.completed)
                            .onTapGesture {
                                realmManager.updateTask(id: task.id, completed: !task.completed)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive,
                                       action: {
                                    DispatchQueue.main.async {
                                        realmManager.deleteTask(id: task.id)
                                    }
                                },
                                       label: {
                                    Label("Delete", systemImage: "trash")
                                })
                            }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .background(.red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(RealmManager())
    }
}
