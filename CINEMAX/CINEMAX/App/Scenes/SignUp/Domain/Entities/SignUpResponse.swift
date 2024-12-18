//
//  SignUpResponse.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 17/12/2024.
//

import Foundation

struct SignUpResponse: Codable {
    let status, message, username, role: String?
}
