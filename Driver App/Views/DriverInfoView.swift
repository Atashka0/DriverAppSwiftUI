import SwiftUI

struct DriverInfoView: View {
    @EnvironmentObject var viewModel: ViewModel
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(ColorScheme.darkBlue)]
    }
    var body: some View {
        NavigationView(content: {
            if let driver = viewModel.driver, let vehicle = viewModel.vehicle {
                ScrollView {
                    VStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(spacing: 10) {
                                Image("user")
                                Text("\(driver.firstName) \(driver.lastName)")
                                    .foregroundColor(.black)
                                    .font(.title2.bold())
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            Text("IIN: \(driver.iin)")
                            Text("Address: \(driver.address)")
                            Text("Phone number: \(driver.phoneNumber)")
                            Text("Email: \(driver.email)")
                            Text("Driving license code: \(driver.driverLicenseCode)")
                            
                        }
                        .foregroundColor(.gray)
                        
                        .font(.system(size: 18))
                        .padding()
                        .overlay(RoundedRectangle(
                            cornerRadius: 15
                        ).stroke(Color(uiColor: .systemGray4), lineWidth: 2))
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(spacing: 10) {
                                Image("car")
                                Text("\(vehicle.licensePlate)")
                                    .foregroundColor(.black)
                                    .font(.title2.bold())
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            Text("Model: \(vehicle.model)")
                            Text("Year: \(vehicle.yearConstructed)")
                            Text("License plate: \(vehicle.licensePlate)")
                            Text("Sitting capacity: \(vehicle.sittingCapacity)")
                            
                        }
                        .foregroundColor(.gray)
                        
                        .font(.system(size: 18))
                        .padding()
                        .overlay(RoundedRectangle(
                            cornerRadius: 15
                        ).stroke(Color(uiColor: .systemGray4), lineWidth: 2))
                        Spacer()
                        Button {
                            viewModel.userLoggedIn = false
                        } label: {
                            Text("Log Out")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 45)
                                .overlay(RoundedRectangle(
                                    cornerRadius: 10
                                ).stroke(ColorScheme.darkBlue, lineWidth: 3))
                                .background(ColorScheme.darkBlue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                    }
                    .navigationTitle(Text("Profile"))
                    .padding()
                }
            }
        })
    }
}

#Preview {
    DriverInfoView()
}
