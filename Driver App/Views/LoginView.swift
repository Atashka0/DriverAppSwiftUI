import SwiftUI
import CoreLocation


struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isMainTabViewActive: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    var locationManager = CLLocationManager()
    @State var errorString = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: geometry.size.height * RegLogConstants.verticalSpacing) {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: 200,
                            height: geometry.size.height * RegLogConstants.logoSize
                        )
                    TextField("Username",text: $username)
                        .modifier(TextFieldModifier())
                    
                    CustomSecureField(placeholder: "Password", rightView: AssetNames.eye, text: $password)
                        .modifier(TextFieldModifier())
                    
                    
                    Button(action: {
                        Task {
                            do {
                                let result = try await APIMananger.fetchDriver(username: username, password: password)
                                switch result {
                                case .success(let rootObject):
                                    errorString = ""
                                    viewModel.driver = rootObject?.driver
                                    viewModel.vehicle = rootObject?.vehicle
                                    viewModel.userLoggedIn = true
                                    let result = try await APIMananger.getHistory(id: viewModel.driver?.id ?? 1)
                                    switch result {
                                    case .success(let historyResponse):
                                        viewModel.history = historyResponse?.object ?? []
                                    case .failure(let error):
                                        print("Login failed: \(error)")
                                    }
                                    
                                    let result2 = try await APIMananger.getTasks(id: viewModel.driver?.id ?? 1)
                                    switch result2 {
                                    case .success(let historyResponse):
                                        viewModel.tasks = historyResponse?.object ?? []
                                    case .failure(let error):
                                        print("Login failed: \(error)")
                                    }
                                    
                                    let result3 = try await APIMananger.curTask(id: viewModel.driver?.id ?? 1)
                                    switch result3 {
                                    case .success(let curTaskResponse):
                                        guard let curTask = curTaskResponse?.object else { return }
                                        viewModel.curTask = curTask
                                    case .failure(let error):
                                        print("Login failed: \(error)")
                                    }
                                case .failure(let error):
                                    print("Login failed: \(error)")
                                    errorString = "Username or Password is wrong."
                                }
                            } catch {
                                print("Error calling fetchDriver: \(error)")
                                errorString = "Username or Password is wrong."
                            }
                        }
                    }) {
                        Text("Login")
                            .modifier(ButtonModifier())
                    }
                    if errorString == "" {
                        EmptyView()
                    } else {
                        Text(errorString)
                            .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.textSize))
                            .foregroundColor(.red)
                            .frame(height: Constants.textFieldHeight, alignment: .leading)
                    }
                    
                    Spacer()
                    Divider()
                    HStack {
                        Text("Don't have an account?")
                            .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.textSize))
                        Button {
                            
                        } label: {
                            Text("Sign Up")
                                .font(Font.custom(FontNames.jostSemiBold, size: GlobalConstants.textSize))
                        }
                    }
                    .foregroundColor(ColorScheme.grayAndWhite)
                    .font(.footnote)
                    .padding(.bottom, geometry.size.height * RegLogConstants.bottomViewBottomPadding)
                    .padding(.top, geometry.size.height * RegLogConstants.bottomViewTopPadding)
                }
                .navigationBarBackButtonHidden(true)
                .padding(.horizontal)
                
                NavigationLink("", destination: MainTabView(), isActive: $viewModel.userLoggedIn)
                    .hidden()
            }
        }
        .preferredColorScheme(.light)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

struct RegLogConstants {
    static let logoVerticalPadding = 0.07
    static let verticalSpacing = 0.015
    static let bottomViewBottomPadding = 0.01
    static let bottomViewTopPadding = 0.005
    static let logoSize = 0.2
    static let buttonHeight: CGFloat = 50
}

public struct ButtonModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.textSize))
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: RegLogConstants.buttonHeight)
            .foregroundColor(.white)
            .background(ColorScheme.darkBlue)
            .contentShape(Rectangle())
            .overlay(RoundedRectangle(
                cornerRadius: GlobalConstants.buttonCornerRadius)
                .stroke(Color(uiColor: .systemBackground))
            )
            .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.buttonCornerRadius))
    }
}
