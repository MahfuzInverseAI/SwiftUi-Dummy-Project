//
//  TaskJoinVIew.swift
//  DummyProject
//
//  Created by Mahfuz on 15/1/25.
//

import SwiftUI

struct TaskJoinVIew: View {
    @Binding var tasks: [TaskViewModel]
    @Binding var selectedTask: TaskStatus
    @State var title: String = ""
    @State var description: String = ""
    @State var dateTime: Date = Date()

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    selectedTask = .mainPart
                }
                Spacer()
                Button("Save") {
                    if !title.isEmpty && !description.isEmpty {
                        tasks.append(
                            TaskViewModel(
                                title: title, description: description,
                                dateTime: dateTime))
                        selectedTask = .mainPart
                    }

                }
            }
            //            .padding()
            .font(.title2)
            .foregroundStyle(.black)

            Rectangle()
                .fill(.white)
                .overlay(alignment: .top) {
                    VStack(spacing: 40) {

                        //                                    createFieldView(name: "Enter Title")
                        TextField(" Enter Title", text: $title)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .border(Color.black, width: 3)
                            .cornerRadius(5)
                            .bold()

                        TextField(
                            " Enter Description", text: $description
                        )
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .border(Color.black, width: 3)
                        .cornerRadius(5)
                        .bold()

                        DatePicker(
                            "Select Date", selection: $dateTime)
                    }
                }
        }
        .padding()
        //        Spacer()

    }
}

#Preview {
    @Previewable @State var tasks: [TaskViewModel] =
        [
            TaskViewModel(
                title: "Title 1", description: "Des",
                dateTime: Date(timeIntervalSinceNow: 30))
        ]
    @Previewable @State var selectedTask: TaskStatus = .taskJoin
    TaskJoinVIew(tasks: $tasks, selectedTask: $selectedTask)
}
