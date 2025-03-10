
//  ApplicationStation
//
//  Created by Darian Lee on 3/9/25.
//

import Foundation

class RagAPI{
    func askQuestion(question: String, completion: @escaping (String?) -> Void) {
        print(question)
        
        guard let url = URL(string: "http://127.0.0.1:1760/ask") else {
            print("incorrect URL")
            completion(nil)
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["question": question]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("issue with request: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            
            guard let data = data else {
                print("no data from server")
                completion(nil)
                return
            }
            
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let answer = json["answer"] as? String {
                print(answer)
                completion(answer)
            } else {
                print("🥺🥺🥺🥺🥺🥺🥺🥺🥺🥺🥺")
                print(data)
                print("couldn't parse answer")
                completion(nil)
            }
        }
        
        
        task.resume()
    }
    
}
