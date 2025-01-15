//
//  MainPart.swift
//  DummyProject
//
//  Created by Mahfuz on 14/1/25.
//

import SwiftUI

struct MainPart: View {
    @Binding var tasks: [TaskViewModel]
    @Binding var selectedTask: TaskStatus
    @Binding var indexed: Int?
    @State var popOver: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 1) {
                HStack {
                    Text("App Title")
                    Spacer()
                    Button {
                        // other screen
                        selectedTask = .taskJoin
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.blue)
                    }
                }
                .font(.largeTitle)
                .bold(true)

                HStack {
                    Text("List")
                        .padding(.top)
                        .font(.headline)
                    Spacer()
                }

                ScrollView {
                    ForEach(tasks.indices, id: \.self) { index in
                        Rectangle()
                            .stroke(lineWidth: 5)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .cornerRadius(5)
                            .overlay {
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        selectedTask = .taskDisplay
                                        indexed = index
                                    } label: {
                                        Text("\(tasks[index].title)")
                                            .font(.headline)
                                            .foregroundStyle(.black)
                                    }
                                    Spacer()
                                    Button {
                                        popOver = true
                                        indexed = index
                                    } label: {
                                        Image(systemName: "line.3.horizontal")
                                            .foregroundStyle(.black)
                                    }
                                    
                                    .padding()
                                    
                                }
                                
                            }
                        
                    }
                    .padding(.top)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            if popOver {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
                    .frame(maxWidth: 250, maxHeight: 250)
                    .overlay(alignment: .top) {
                        VStack {
                            HStack(alignment: .top) {
                                Button {
                                    popOver = false
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.white)
                                        .padding()
                                        .scaledToFit()
                                }
                                Spacer()

                            }

                            Spacer()

                            Divider()
                                //                                .frame(height: 1)
                                .background(.white)
                                .padding(.horizontal)

                            Button {
                                selectedTask = .taskUpdate
                                popOver = false
                            } label: {
                                Text("Update")
                                    .foregroundStyle(.white)
                                    .bold()
                                    .font(.headline)

                            }

                            Divider()
                                //                                .frame(height: 1)
                                .background(.white)
                                .padding(.horizontal)

                            Button {
                                selectedTask = .taskDelete
                                popOver = false
                            } label: {
                                Text("Delete")
                                    .foregroundStyle(.white)
                                    .bold()
                                    .font(.headline)

                            }

                            Divider()
                                //                                .frame(height: 1)
                                .background(.white)
                                .padding(.horizontal)

                            Spacer()

                        }
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
    MainPart(
        tasks: $tasks, selectedTask: $selectedTask,
        indexed:
            $indexed)
}
