//
//  NetworkManager.swift
//  SplashList
//
//  Created by Tushar on 13/04/24.
//

import Foundation
import Reachability

class NetworkManager {
    static let shared = NetworkManager()
    let reachability = try! Reachability()

    init() {
        startMonitoring()
    }

    private func startMonitoring() {
        reachability.whenReachable = { reachability in
            print("Network reachable.")
        }
        reachability.whenUnreachable = { _ in
            print("Network not reachable.")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start network reachability notifier.")
        }
    }

    deinit {
        reachability.stopNotifier()
    }

    func isNetworkAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
}
