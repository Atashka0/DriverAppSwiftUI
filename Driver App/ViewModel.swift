//
//  ViewModel.swift
//  Driver App
//
//  Created by Ilyas Kudaibergenov on 29.11.2023.
//
import SwiftUI

class ViewModel: ObservableObject {
    init(driver: Driver?, vehicle: Vehicle?, history: [TaskObject] = [], tasks: [TaskObject] = [], curTask: TaskObject = TaskObject(id: 3, title: "", description: "", state: "", duration: 13, createdAt: "")) {
        self.driver = driver
        self.vehicle = vehicle
        self.history = history
        self.tasks = tasks
        self.curTask = curTask
    }
    @Published var userLoggedIn: Bool = false
    @Published var driver: Driver?
    @Published var vehicle: Vehicle?
    @Published var history: [TaskObject]
    @Published var tasks: [TaskObject]
    @Published var curTask: TaskObject
}
