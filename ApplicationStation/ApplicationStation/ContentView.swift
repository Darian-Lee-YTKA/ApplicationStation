import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authManager: AuthManager
    let lightBlue = Color(red: 173/255, green: 255/255, blue: 255/255)

    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Welcome to the ApplicationStation")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("UCSC NLP's central application hub")
                    .font(.headline)
                    .foregroundColor(lightBlue)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    // Login action
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(lightBlue)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Text("Sign Up")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
                    .padding(.top, 20)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .background(Color.black)
                    .foregroundColor(.black)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .background(Color.black)
                    .foregroundColor(.black)
                
                Button(action: {
                    // Sign-up action
                    authManager.signUp(email: email, password: password) { error in
                        if let error = error {
                            print(error)
                        } else {
                            // After successful sign-up, you can call sign-in
                            authManager.signIn(email: email, password: password) { success in
                                if !success {
                                    print("Sign-in failed")
                                } else {
                                    print("👩🏻‍🦰", authManager.user)
                                }
                            }
                        }
                    }
                }) {
                    Text("Create Account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager()) // Correct preview setup
}

