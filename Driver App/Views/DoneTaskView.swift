import SwiftUI

struct DoneTaskView: View {
    let duration: String
    let title: String
    let description: String
    let date: String
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: .leading, spacing: 10, content: {
                Text(title)
                    .font(.system(size: 20))
                    .bold()
                
                Text(description)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .font(.system(size: 14))
                                   .fixedSize(horizontal: false, vertical: true)
                Spacer()
                HStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text(date)
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "clock")
                        Text(duration)
                    }
                }
                .foregroundStyle(ColorScheme.darkBlue)
            })
        })
        
        .padding()
        .overlay(RoundedRectangle(
            cornerRadius: 15
        ).stroke(Color(uiColor: .systemGray4), lineWidth: 2))
        .frame(height: 150)
        
    }
}

//#Preview {
//    VStack {
//        
//        DoneTaskView(duration: "2 hr", title: "McDonalds delivery", description: "Take the order from McDonalds #94. Deliver the order to Qabanbay Ave. 53", date: "11 Nov 2023")
//        
//    }
//}
