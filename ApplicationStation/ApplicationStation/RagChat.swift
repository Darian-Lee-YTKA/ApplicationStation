import SwiftUI

struct RagChat: View {
    @State private var userMessage: String = ""
    @State private var messages: [String] = [
        "AI: Hello! How can I assist you today?",
        "User: I need help with coding.",
        "AI: Sure, what exactly do you need help with?"
    ]
    let lightBlue = Color(red: 173/255, green: 255/255, blue: 255/255)
    
    var body: some View {
        VStack {
            // Chat Messages
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(messages, id: \.self) { message in
                        Text(message)
                            .padding()
                            .foregroundColor(lightBlue)
                            .background(message.starts(with: "User") ? Color.gray.opacity(0.3) : Color.clear)
                            .cornerRadius(10)
                            .padding(.bottom, 5) // Adding padding to prevent messages from sticking together
                    }
                }
                .padding(.top, 80) // Added padding to give space from the top
                .padding(.horizontal) // Added horizontal padding for better layout
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
                        messages.append("User: \(userMessage)")
                        messages.append("AI: I'm processing your request.")
                        userMessage = ""
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
    }
}

#Preview {
    RagChat()
}

