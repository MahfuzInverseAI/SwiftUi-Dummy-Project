//
//  MainScreen.swift
//  Task manager
//
//  Created by Mahfuz on 20/1/25.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var manager: TaskFileManager
    @State var showAlert: Bool = false
    @State var deletedID: String? = nil
    @State private var searchText: String = ""

    var filteredTasks: [String] {
        if searchText.isEmpty {
            return manager.fileNames
        } else {
            return manager.fileNames.filter { fileName in
                if let task = manager.readTaskFromFile(id: fileName) {
                    return task.title.localizedCaseInsensitiveContains(searchText)
                }
                return false
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search tasks...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Group {
                    if filteredTasks.isEmpty {
                        VStack {
                            Image(systemName: "tray")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .padding()

                            Text("No Tasks Available")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding()
                    } else {
                        List {
                            Section(header: Text("Task List")) {
                                ForEach(filteredTasks.indices, id: \ .self) { index in
                                    if let task = manager.readTaskFromFile(id: filteredTasks[index]) {
                                        HStack {
                                            NavigationLink {
                                                TaskDisplay(task: task)
                                            } label: {
                                                VStack(alignment: .leading) {
                                                    Text("\(task.title)")
                                                        .font(.headline)
                                                }
                                            }
                                            .buttonStyle(PlainButtonStyle())

                                            Spacer()

                                            Menu {
                                                NavigationLink {
                                                    TaskEditView(fileName: filteredTasks[index])
                                                } label: {
                                                    Text("Update")
                                                }

                                                Button {
                                                    showAlert.toggle()
                                                    deletedID = filteredTasks[index]
                                                } label: {
                                                    Text("Delete")
                                                }
                                                .frame(
                                                    maxWidth: .infinity,
                                                    maxHeight: .infinity
                                                )
                                            } label: {
                                                Image(systemName: "line.3.horizontal")
                                                    .padding(.horizontal)
                                                    .frame(maxHeight: .infinity)
                                                    .tint(Color.primary)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text(""),
                        primaryButton: .destructive(Text("Yes")) {
                            if let deletedID {
                                manager.deleteTaskFile(id: deletedID)
                            }
                        },
                        secondaryButton: .cancel(Text("No")) {}
                    )
                }
            }
            .navigationBarItems(
                leading: Text("Task Manager").bold().font(.title),
                trailing: NavigationLink(destination: {
                    TaskAdd()
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.title)
                })
            )
        }
        .onAppear {
            manager.update()
        }
    }
}

#Preview {
    MainScreen()
}
