import SwiftUI
import MapKit
import CoreLocation


struct MapView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @State var hidden: Bool = false
    @State var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        GeometryReader { geometry in
            Map(position: $camera) {
            }
            .safeAreaInset(edge: .bottom, content: {
                VStack(alignment: .trailing) {
                    if !hidden {
                        TaskView(id: viewModel.curTask.id, title: viewModel.curTask.title, description: viewModel.curTask.description, taskStatus: .canEnd)
                            .padding()
                    } else {
                    }
                }
            })
            .task {
                do {
                    let result = try await APIMananger.curTask(id: viewModel.driver?.id ?? 0)
                    print(result)
                    switch result {
                    case .success(let tasksResponse):
                    let curTask = tasksResponse?.object
                    viewModel.curTask = TaskObject(id: curTask?.id ?? 1, title: curTask?.title ?? "", description: curTask?.description ?? "", state: curTask?.state ?? "", duration: curTask?.duration ?? 0, createdAt: curTask?.createdAt ?? "")
                    viewModel.curTask = curTask!
                    hidden = false
                    case .failure(let error):
                        print("Failed to fetch tasks: \(error)")
                        viewModel.curTask.state = ""
                        hidden = true
                    }
                } catch {
                    print("Error calling getTasks: \(error)")
                }
            }
            .mapStyle(.standard)
            .mapControls({
                MapUserLocationButton()
                    .frame(width: 170, height: 170)
            })
            .toolbar(.hidden)
            .onAppear {
                if CLLocationManager.locationServicesEnabled() {
                    if locationDataManager.locationManager.authorizationStatus == .notDetermined {
                        locationDataManager.locationManager.requestWhenInUseAuthorization()
                    }
                }
            }
        }
    }
}

struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
