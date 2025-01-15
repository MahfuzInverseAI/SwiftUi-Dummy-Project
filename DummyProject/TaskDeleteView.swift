//
//  TaskDeleteView.swift
//  DummyProject
//
//  Created by Mahfuz on 15/1/25.
//

import SwiftUI

struct TaskDeleteView: View {
    @Binding var tasks: [TaskViewModel]
    @Binding var selectedTask: TaskStatus
    @Binding var indexed: Int?
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .frame(maxWidth: 250, maxHeight: 100)
                .overlay(alignment: .top) {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                tasks.remove(at: indexed!)
                                selectedTask = .mainPart

                            } label: {
                                Text("Yes")
                                    .font(.largeTitle)
                            }
                            Spacer()
                            Spacer()
                            Spacer()
                            Button {
                                selectedTask = .mainPart
                            } label: {
                                Text("No")
                                    .font(.largeTitle)

                            }
                            Spacer()
                        }
                        //                    .padding()
                        .foregroundStyle(.white.opacity(0.8))
                        Spacer()
                    }
                }
        }

    }
}

#Preview {
    @Previewable @State var tasks: [TaskViewModel] = [
        TaskViewModel(
            title: "Title 1", description: "Des",
            dateTime: Date(timeIntervalSinceNow: 30)),
        TaskViewModel(
            title: "Title 2", description: "Des",
            dateTime: Date(timeIntervalSinceNow: 30)),
        TaskViewModel(
            title: "Title 3", description: "Des",
            dateTime: Date(timeIntervalSinceNow: 30)),
        TaskViewModel(
            title: "Title 4", description: "Des",
            dateTime: Date(timeIntervalSinceNow: 30)),
    ]
    @Previewable @State var selectedTask: TaskStatus = .mainPart
    @Previewable @State var indexed: Int? = nil
    TaskDeleteView(
        tasks: $tasks, selectedTask: $selectedTask, indexed: $indexed)
}
