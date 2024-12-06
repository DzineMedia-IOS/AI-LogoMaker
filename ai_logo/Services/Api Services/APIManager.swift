//
//  APIManager.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/5/24.
//

import Foundation


class APIManager {
    static let shared = APIManager()
    private init() {}
    private let apiURL = "https://imageai.oneupgamestudio.com/api-logo"

    // Fetch the API Key from the app's Info.plist
    private var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
    
    /// Function to generate a logo using the API
    
    
    func generateLogo(prompt: String, completion: @escaping (Result<LogoResponse, Error>) -> Void) {
           guard let url = URL(string: apiURL) else {
               completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue(apiKey, forHTTPHeaderField: "Dzine-Media-API")
           
           // Prepare the form-data body
           let parameters: [String: Any] = [
               "prompt": prompt,
               "num_inference_steps": 30,
               "height": 256,
               "width": 256
           ]
           
           request.httpBody = parameters
               .compactMap { "\($0.key)=\($0.value)" }
               .joined(separator: "&")
               .data(using: .utf8)
           
           request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                   return
               }
               
               // Debug: Log the raw response
               if let rawResponse = String(data: data, encoding: .utf8) {
                   print("Raw Response: \(rawResponse)")
               }
               
               do {
                   let decodedResponse = try JSONDecoder().decode(LogoResponse.self, from: data)
                   completion(.success(decodedResponse))
               } catch {
                   completion(.failure(error))
               }
           }
           
           task.resume()
       }
}
