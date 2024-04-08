
import SwiftUI

struct MainTabView: View {
    
    @State var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            MapView()
                .onTapGesture {
                    selectedTab = 0
                }
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }.tag(0)
            TasksView()
                .onTapGesture {
                    selectedTab = 1
                }
                .tabItem {
                    VStack {
                        Image(systemName: "flag.checkered")
                        Text("Tasks")
                    }
                }.tag(1)
            DriverHistoryView()
                .onTapGesture {
                    selectedTab = 2
                }
                .tabItem {
                    VStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("History")
                    }
                }.tag(2)
            DriverInfoView()
                .onTapGesture {
                    selectedTab = 3
                }
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }.tag(3)
        }
        .tint(ColorScheme.darkBlue)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
