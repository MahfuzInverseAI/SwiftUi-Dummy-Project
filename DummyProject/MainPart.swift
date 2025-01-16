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
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo, Color.purple]),
                    startPoint: .top, endPoint: .bottom
                )
                .opacity(1)
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 1) {
                    HStack {
                        Text("List")
                            .foregroundStyle(.white)
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
                                        .disabled(popOver)
                                        Spacer()
                                        Button {
                                            withAnimation(.easeInOut) {
                                                popOver.toggle()
                                            }
                                            indexed = index
                                        } label: {
                                            Image(
                                                systemName: "line.3.horizontal"
                                            )
                                            .foregroundStyle(.black)
                                        }
                                        .disabled(popOver)

                                        .padding()

                                    }

                                }
                                .background(.white)
                                .cornerRadius(5)

                        }
                        .padding(.top)
                    }
                }
                .padding()

                if popOver {
                    RoundedRectangle(cornerRadius: 10)
                        //                    .fill(.gray)
                        .foregroundStyle(
                            .linearGradient(
                                colors: [
                                    .black.opacity(0.7), .black.opacity(0.8),
                                    .black.opacity(0.9), .black,
                                ], startPoint: .top, endPoint: .bottom)
                        )
                        .frame(maxWidth: 250, maxHeight: 250)
                        .overlay(alignment: .top) {
                            VStack {
                                HStack(alignment: .top) {
                                    Button {
                                        withAnimation(.easeInOut) {
                                            popOver.toggle()
                                        }
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
            .navigationBarItems(leading: Text("App Title").font(.largeTitle)
                .foregroundStyle(.white)
                                ,
                                trailing: Button {
                
                selectedTask = .taskJoin
            } label: {
                Image(systemName: "plus.circle")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .foregroundStyle(.blue)
            })
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
