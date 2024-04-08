//
//  Driver_AppApp.swift
//  Driver App
//
//  Created by Ilyas Kudaibergenov on 02.11.2023.
//

import SwiftUI

@main
struct Driver_AppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = ViewModel(driver: nil, vehicle: nil, tasks: [])

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
