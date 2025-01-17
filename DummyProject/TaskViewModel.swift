//
//  TaskViewModel.swift
//  DummyProject
//
//  Created by Mahfuz on 17/1/25.
//

import Foundation
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
