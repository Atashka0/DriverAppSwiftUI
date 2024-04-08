//
//  APICaller.swift
//  Driver App
//
//  Created by Ilyas Kudaibergenov on 29.11.2023.
//

import Foundation

struct APIMananger {
    static public func fetchDriver(username: String, password: String) async -> Result<RootObject?, Error> {
        let url = URL(string: "https://vms-team3.onrender.com/driver/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userData = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            do {
                    let user = try decoder.decode(RootObject.self, from: data)
                    print(user.driver.firstName)
                    return Result.success(user)
                } catch {
                    print("Decoding Error: \(error)")
                    return Result.failure(error)
                }
        } catch {
            return Result.failure(error)
        }
    }
    
    static public func getHistory(id: Int) async -> Result<HistoryResponse?, Error> {
        let url = URL(string: "https://vms-team3.onrender.com/driver/\(id)/history")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            do {
                let historyResponse = try decoder.decode(HistoryResponse.self, from: data)
                print("Status: \(historyResponse.status)")
                print("Message: \(historyResponse.message)")
                for task in historyResponse.object {
                    print("Task ID: \(task.id), Title: \(task.title), State: \(task.state)")
                }
                return Result.success(historyResponse)
            } catch {
                print("Decoding Error: \(error)")
                return Result.failure(error)
            }
        } catch {
            return Result.failure(error)
        }
    }

    static public func getTasks(id: Int) async -> Result<HistoryResponse?, Error> {
        let url = URL(string: "https://vms-team3.onrender.com/driver/\(id)/tasks")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            do {
                let historyResponse = try decoder.decode(HistoryResponse.self, from: data)
                print("Status: \(historyResponse.status)")
                print("Message: \(historyResponse.message)")
                for task in historyResponse.object {
                    print("Task ID: \(task.id), Title: \(task.title), State: \(task.state)")
                }
                return Result.success(historyResponse)
            } catch {
                print("Decoding Error: \(error)")
                return Result.failure(error)
            }
        } catch {
            return Result.failure(error)
        }
    }
    
    static public func curTask(id: Int) async -> Result<CurTaskResponse?, Error> {
        let url = URL(string: "https://vms-team3.onrender.com/driver/\(id)/current-task")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            do {
                let historyResponse = try decoder.decode(CurTaskResponse.self, from: data)
                print("Status: \(historyResponse.status)")
                print("Message: \(historyResponse.message)")
                return Result.success(historyResponse)
            } catch {
                print("Decoding Error: \(error)")
                return Result.failure(error)
            }
        } catch {
            return Result.failure(error)
        }
    }
    
    static public func startTask(id: Int) async {
        let url = URL(string: "https://vms-team3.onrender.com/task/\(id)/start")!
//        let url = URL(string: "192.168.178.1:8081/task/\(id)/start")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
        } catch {
        }
    }
    
    static public func endTask(id: Int) async {
        let url = URL(string: "https://vms-team3.onrender.com/task/\(id)/mark-as-completed")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
        } catch {
        }
    }
}

struct TaskObject: Codable {
    let id: Int
    let title: String
    let description: String
    var state: String
    var duration: Int
    var createdAt: String
    enum CodingKeys: String, CodingKey {
        case id, title, description, state, duration
        case createdAt = "created_at"
    }
}

struct HistoryResponse: Codable {
    let status: String
    let message: String
    let localDateTime: String
    let object: [TaskObject]
}


struct CurTaskResponse: Codable {
    let status: String
    let message: String
    let localDateTime: String
    let object: TaskObject
}

struct User: Codable {
    let username: String
    let role: String
    let time: String
}

struct Driver: Codable {
    let id: Int
    let iin: String
    let address: String
    let email: String
    let user: User
    let govId: Int
    let firstName: String
    let middleName: String
    let lastName: String
    let phoneNumber: String
    let driverLicenseCode: Int
    
    enum CodingKeys: String, CodingKey {
            case id, iin, address, email, user
            case govId = "gov_id"
            case firstName = "first_name"
            case middleName = "middle_name"
            case lastName = "last_name"
            case phoneNumber = "phone_number"
            case driverLicenseCode = "driver_license_code"
        }
}

struct Vehicle: Codable {
    let id: Int
    let make: String
    let model: String
    let type: String
    let driver: Driver
    let yearConstructed: Int
    let licensePlate: String
    let sittingCapacity: Int
    enum CodingKeys: String, CodingKey {
        case id, make, model, type, driver
            case yearConstructed = "year_constructed"
            case licensePlate = "license_plate"
            case sittingCapacity = "sitting_capacity"
        }
}

struct RootObject: Codable {
    let driver: Driver
    let vehicle: Vehicle
}

