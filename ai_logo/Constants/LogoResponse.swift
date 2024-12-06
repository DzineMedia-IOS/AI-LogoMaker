//
//  LogoResponse.swift
//  ai_logo
//
//  Created by LAP__TECH on 12/5/24.
//

import Foundation
struct LogoResponse: Decodable {
    let cost: Double
    let seed: Int
    let url: String
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            "\(key)=\(value)"
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
