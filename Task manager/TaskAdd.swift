//
//  TaskAdd.swift
//  Task manager
//
//  Created by Mahfuz on 20/1/25.
//

import SwiftUI

struct TaskAdd: View {
    @EnvironmentObject var manager: TaskFileManager
    @State var task: TaskViewModel = TaskViewModel(title: "", description: "", dateAndTime: .now, isNotificationEnabled: false)
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Title")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    TextField("Enter task title", text: $task.title)
                        .font(.headline)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    TextEditor(text: $task.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .frame(minHeight: 100, maxHeight: 150)
                        .shadow(radius: 5)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Date & Time")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    DatePicker(
                        "Select Date & Time",
                        selection: $task.dateAndTime,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding(.vertical, 10)
                }
                
                Divider() // Separator
                
                // Notification Toggle Section
                VStack(alignment: .leading) {
                    Toggle(isOn: $task.isNotificationEnabled) {
                        Text("Enable Notifications")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .padding(.vertical, 10)
                }

//                Button(action: {
//                    
//                    
//                    
//                }) {
//                    Text("Submit")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//                }
//                .padding(.top, 20)
//                .padding(.bottom, 20) // Adds space at the bottom of the button
//                .disabled(task.title.isEmpty)

            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding([.top, .horizontal])
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("New Task")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button{
            print("Save")
            TaskNotificationManager.shared.addNotification(for: task)
            manager.writeTaskToFile(task: task)
            manager.update()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Save")
                .foregroundStyle(.blue)
        }
            .padding(.bottom, 5)
            .disabled(task.title.isEmpty)
        )
    }
}

#Preview {
    TaskAdd()
}
