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
                .font(.title3)
                .foregroundStyle(.white)
//                .bold()
            
            Spacer()
        }
        Rectangle()
            .stroke(lineWidth: 5)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .cornerRadius(5)
            .background(.white)
            .cornerRadius(5)
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
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.purple]), startPoint: .top, endPoint: .bottom)
                    .opacity(1)
                    .edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .top) {
                    Color.clear
                        .navigationBarItems(leading: Button("Back"){
                            
                        }
                            .font(.title2)
                            .foregroundColor(Color.white)
                        )
                    VStack(spacing: 40) {
                        
                        displayTask(type: "Title", name: task.title)
                        displayTask(
                            type: "Description",
                            name: task.description)
                        displayTask(
                            type: "Date and Time",
                            name: task.getTime())
                        
                    }

                }.padding()
                
            }
            
        }

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
