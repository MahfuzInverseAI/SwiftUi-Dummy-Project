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
//            Color.gray.opacity(0.5)
            LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.purple]), startPoint: .top, endPoint: .bottom)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            Color.clear
                .opacity(0)
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text(""),
                        primaryButton: .destructive(Text("Yes")) {
                            tasks.remove(at: indexed!)
                            selectedTask = .mainPart

                        },
                        secondaryButton: .cancel(Text("No")) {
                            selectedTask = .mainPart
                        }
                    )
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
    @Previewable @State var indexed: Int? = 1
    TaskDeleteView(
        tasks: $tasks, selectedTask: $selectedTask, indexed: $indexed)
}
