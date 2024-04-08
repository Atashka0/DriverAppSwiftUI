import SwiftUI

struct TasksView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(ColorScheme.darkBlue)]
       }
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(viewModel.tasks, id: \.id) { task in
                        TaskView(id: task.id, title: task.title, description: task.description, taskStatus: task.state == "PENDING" ? .canStart : .canEnd)
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle(Text("Tasks"))
            }
        }
        .task {
            do {
                let result = try await APIMananger.getTasks(id: viewModel.driver?.id ?? 0)
                switch result {
                case .success(let tasksResponse):
                    viewModel.tasks = tasksResponse?.object ?? []
                case .failure(let error):
                    print("Failed to fetch tasks: \(error)")
                }
            } catch {
                print("Error calling getTasks: \(error)")
            }
        }
    }
}

#Preview {
    DriverHistoryView()
}
