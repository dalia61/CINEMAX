//
//  UserDefaultsManager.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 18/12/2024.
//

import Foundation

protocol DataManagerProtocol {
    func saveData(_ data: Data, forKey key: String)
    func updateData(_ data: Data, forKey key: String)
    func data(forKey key: String) -> Data?
    func removeData(forKey key: String)
}

struct UserDefaultsManager: DataManagerProtocol {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveData(_ data: Data, forKey key: String) {
        userDefaults.set(data, forKey: key)
    }

    func updateData(_ data: Data, forKey key: String) {
        userDefaults.set(data, forKey: key)
    }

    func data(forKey key: String) -> Data? {
        userDefaults.data(forKey: key)
    }

    func removeData(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
