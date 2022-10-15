//
//  TaskRow.swift
//  ToDoList
//
//  Created by Mirza Baig on 01/10/22.
//

import SwiftUI

struct TaskRow: View {
    
    var task: String
    var completed: Bool
    
    var body: some View {
        HStack{
            Image(systemName: completed ? "checkmark.circle" : "circle" )
            
            Text(task)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Take Grocery", completed: true)
    }
}
