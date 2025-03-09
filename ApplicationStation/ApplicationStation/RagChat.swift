import SwiftUI
import FirebaseFirestore

struct RagChat: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var dataManager: DataManager
    @State private var userMessage: String = ""
    let lightBlue = Color(red: 173/255, green: 255/255, blue: 255/255)
    
    var body: some View {
        VStack {
            HStack {
                // Logout Button
                Button(action: {
                    authManager.signOut()
                }) {
                    Text("Logout")
                        .padding()
                        .foregroundColor(.white)
                }
                Spacer()
                // Forum Button
                Button(action: {
                    print("Forum tapped")
                }) {
                    Text("Forum")
                        .padding()
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 40)

            // Chat Messages
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(dataManager.messages, id: \.self) { message in
                        HStack(alignment: .bottom) {
                            Text(message.message)
                                .padding()
                                .foregroundColor(lightBlue)
                                .background(message.message.starts(with: "User") ? Color.gray.opacity(0.3) : Color.clear)
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(formatTimestamp(message.timeStamp))
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                        .padding(.bottom, 5)
                    }
                }
                .padding(.top, 80)
                .padding(.horizontal)
            }

            // Input Field for the User's Question
            HStack {
                TextField("Ask a question...", text: $userMessage)
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Button(action: {
                    if !userMessage.isEmpty {
                        let newMessage = Message(message: "User: " + userMessage, timeStamp: Timestamp(date: Date()))
                        dataManager.saveMessages(new_message: newMessage) {
                            userMessage = ""
                            dataManager.loadMessages {
  
                            }
                        }
                    }
                }) {
                    Text("Send")
                        .padding()
                        .foregroundColor(.black)
                        .background(lightBlue)
                        .cornerRadius(10)
                        .padding(.trailing)
                }
            }
            .padding(.bottom)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            dataManager.loadMessages {
                print(dataManager.messages)
            
            }
        }
    }
    
    /// Форматирует временную метку в читаемый вид
    private func formatTimestamp(_ timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Формат "часы:минуты"
        return formatter.string(from: date)
    }
}

#Preview {
    RagChat()
        .environmentObject(AuthManager())
        .environmentObject(DataManager())
}

