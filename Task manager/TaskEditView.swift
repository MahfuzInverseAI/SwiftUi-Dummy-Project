//
//  TaskEditView.swift
//  Task manager
//
//  Created by Mahfuz on 20/1/25.
//

import SwiftUI

struct TaskEditView: View {
    @State var task: TaskViewModel
    @EnvironmentObject var manager: TaskFileManager
    @Environment(\.presentationMode) var presentationMode
    var fileName: String = ""
    init(fileName: String) {
        self.fileName = fileName
        task = TaskViewModel(title: "", description: "", dateAndTime: .now)
    }
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
                    
                    Divider() // Separator
                    
                    // Date and Time Section (Editable)
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

//                    Button(action: {
//                        
//                        
//                        
//                    }) {
//                        Text("Submit")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                    }
//                    .padding(.top, 20)
//                    .padding(.bottom, 20) 
//                    .disabled(task.title.isEmpty)

                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding([.top, .horizontal])
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Update Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button{
                print("Save")
                TaskNotificationManager.shared.removeNotification(for: task)
                TaskNotificationManager.shared.addNotification(for: task)
                manager.deleteTaskFile(id: task.id)
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
            .onAppear{
                self.task = manager.readTaskFromFile(id: self.fileName)!
            }
        }
    

}

#Preview {
    
    TaskEditView(fileName: "")
}
