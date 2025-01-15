//
//  ContentView.swift
//  DummyProject
//
//  Created by Mahfuz on 14/1/25.
//

import SwiftUI

struct TaskViewModel: Hashable {
    let id = UUID().uuidString

    let title: String
    let description: String
    let dateTime: Date

    func getTime() -> String {
        return dateTime.formatted(date: .long, time: .shortened)
    }
}

enum TaskStatus {
    case mainPart
    case taskDisplay
    case taskJoin
    case taskUpdate
    case taskDelete
}

let pass = VStack {}

struct ContentView: View {
    @State private var tasks: [TaskViewModel] = [
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
    @State private var selectedTask: TaskStatus = .mainPart
    @State private var indexed: Int? = nil

    var body: some View {
        VStack {
            switch selectedTask {
            case .mainPart:
                MainPart(
                    tasks: $tasks, selectedTask: $selectedTask,
                    indexed: $indexed)
            case .taskDisplay:
                TaskDesplayVIew(
                    task: $tasks[indexed!], selectedTask: $selectedTask)

            case .taskJoin:
                TaskJoinVIew(tasks: $tasks, selectedTask: $selectedTask)
            case .taskUpdate:
                TaskEditView(
                    task: $tasks[indexed!], selectedTask: $selectedTask)
            case .taskDelete:
                TaskDeleteView(
                    tasks: $tasks, selectedTask: $selectedTask,
                    indexed: $indexed)
            }
        }
    }

}

#Preview {
    ContentView()
}
