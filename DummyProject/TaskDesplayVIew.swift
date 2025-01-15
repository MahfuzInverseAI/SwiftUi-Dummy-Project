//
//  TaskDesplayVIew.swift
//  DummyProject
//
//  Created by Mahfuz on 14/1/25.
//

import Foundation
import SwiftUI

func displayTask(type: String, name: String) -> some View {
    VStack(spacing: 0) {
        HStack {
            Text(type)
            Spacer()
        }
        Rectangle()
            .stroke(lineWidth: 5)
            .cornerRadius(5)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .overlay {
                HStack {
                    Spacer()
                    Text("\(name)")
                        .font(.headline)
                    Spacer()

                }
            }
    }
}

struct TaskDesplayVIew: View {
    @Binding var task: TaskViewModel
    @Binding var selectedTask: TaskStatus
    @State private var isLandscape: Bool = UIDevice.current.orientation
        .isLandscape

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("Back") {
                        selectedTask = .mainPart
                    }
                    Spacer()
                    
                }
                //            .padding()
                .font(.title2)
                .foregroundStyle(.black)
                
                Rectangle()
                    .fill(.white)
                    .overlay(alignment: .top) {
                        VStack(spacing: 40) {
                            
                            displayTask(type: "Title", name: task.title)
                            displayTask(
                                type: "Description",
                                name: task.description)
                            displayTask(
                                type: "Date and Time",
                                name: task.getTime())
                            
                        }
                    }
                
            }
//            .padding()
//            Spacer()

        }
        //        Spacer()

    }
}

#Preview {
    @Previewable @State var tasks: TaskViewModel =
        TaskViewModel(
            title: "Title 1", description: "Des",
            dateTime: Date(timeIntervalSinceNow: 30))
    @Previewable @State var selectedTask: TaskStatus = .taskDisplay
    TaskDesplayVIew(task: $tasks, selectedTask: $selectedTask)
}
