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
                                        Menu {
                                            VStack(alignment: .center) {
                                                Button {
                                                    indexed = index
                                                    withAnimation(.default) {
                                                        selectedTask =
                                                            .taskUpdate
                                                    }
                                                } label: {
                                                    Text("Update")
                                                }
                                                Button {
                                                    indexed = index
                                                    withAnimation(.default) {
                                                        selectedTask =
                                                            .taskDelete
                                                    }

                                                } label: {
                                                    Text("Delete")
                                                }

                                            }
                                        } label: {
                                            Image(
                                                systemName: "line.3.horizontal"
                                            )
                                            .foregroundStyle(.black)
                                        }
                                        .bold()
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
            }

            .navigationBarItems(
                leading: Text("App Title")
                    .font(.largeTitle)
                    .foregroundStyle(.white),
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
