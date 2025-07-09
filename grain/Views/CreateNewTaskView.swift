//
//  CreateNewTaskView.swift
//  grain
//
//  Created by Yussuf Sassi on 09.07.25.
//

import SwiftUI

struct CreateNewTaskView: View {
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle: String = ""
    @State private var notes: String = ""
    @State private var dueDate = Date()
    var body: some View {
        Form {
            VStack {
                Text("Create a new Task").font(.system(size: 20))

                TextField("Task Title", text: $taskTitle)
                DatePicker(
                    "Task due at",
                    selection: $dueDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                TextField("Notes", text: $notes).multilineTextAlignment(.leading)
                Button(action: {
                    dismiss()
                }) {
                    Text("Create Task")
                }
            }
        }
    }
}

#Preview {
    CreateNewTaskView()
}

