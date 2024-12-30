//
//  Router.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 25/12/2024.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    public enum Destination: Codable, Hashable {
        case login(username: String?, password: String?)
        case signup
        case tabBar
        case moviesList
        case movieDetails(movieID: Int)
        case actorsList
        case actorDetails(actorID: Int)
    }

    @Published var navPath = NavigationPath()

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
