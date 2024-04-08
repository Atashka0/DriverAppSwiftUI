import SwiftUI

struct TaskView: View {
    let id: Int
    let title: String
    let description: String
    @State var taskStatus: TaskStatus
    @State var hidden = false
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        if hidden {
            EmptyView()
        } else {
            GeometryReader(content: { geometry in
                
                VStack(alignment: .leading, spacing: 10, content: {
                    HStack {
                        Text(title)
                            .font(.system(size: 20))
                            .bold()
                        Spacer()
                    }
                    
                    Text(description)
                        .foregroundColor(Color(uiColor: .systemGray))
                        .font(.system(size: 14))
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    switch taskStatus {
                    case .canStart:
                        Button {
                            Task {
                                await APIMananger.startTask(id: id)
                                taskStatus = .canEnd
                            }
                        } label: {
                            HStack {
                                Image(systemName: "play")
                                Text("Start")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 45)
                            .overlay(RoundedRectangle(
                                cornerRadius: 10
                            ).stroke(ColorScheme.darkBlue, lineWidth: 3))
                            .background(.white)
                            .foregroundColor(ColorScheme.darkBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                    case .canEnd:
                        Button {
                            Task {
                                await APIMananger.endTask(id: id)
                                taskStatus = .hidden
                                hidden = true
                            }
                        } label: {
                            HStack {
                                Image(systemName: "clock")
                                Text("Mark as completed")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 45)
                            .overlay(RoundedRectangle(
                                cornerRadius: 10
                            ).stroke(ColorScheme.darkBlue, lineWidth: 3))
                            .background(ColorScheme.darkBlue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    case .hidden:
                        Text("")
                    }
                })
            })
            .padding()
            .background(.white)
            .overlay(RoundedRectangle(
                cornerRadius: 15
            ).stroke(Color(uiColor: .systemGray4), lineWidth: 4))
            .frame(height: 190)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

//#Preview {
//    VStack {
//        
//        TaskView(time: "00:23:56", title: "McDonalds delivery", description: "Take the order from McDonalds #94. Deliver the order to Qabanbay Ave. 53", taskStatus: .canEnd)
//        
//    }
//}

enum TaskStatus {
    case canStart
    case canEnd
    case hidden
}
