import SwiftUI

struct DriverHistoryView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(viewModel.history, id: \.id) { task in
                        let hours = task.duration/3600 % 10 < 10 ? "0\(task.duration/3600):" : "\(task.duration/3600):"
                        let minutes = task.duration % 3600 / 60 < 10  ? "0\(task.duration % 3600 / 60)" : "\(task.duration % 3600 / 60)"
                        DoneTaskView(
                            duration: hours + minutes + ":00",
                            title: task.title,
                            description: task.description,
                            date: task.createdAt
                        )
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle(Text("History"))
            }
        }
        .task {
            do {
                let result = try await APIMananger.getHistory(id: viewModel.driver?.id ?? 0)
                switch result {
                case .success(let historyResponse):
                    viewModel.history = historyResponse?.object ?? []
                case .failure(let error):
                    print("Failed to fetch tasks: \(error)")
                }
            } catch {
                print("Error calling getTasks: \(error)")
            }
        }
    }
}

struct DriverHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DriverHistoryView()
    }
}
