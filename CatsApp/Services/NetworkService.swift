//
//  NetworkService.swift
//  CatsApp
//
//  Created by Cecile on 08/09/2023.
//

import Foundation
import Network

final class NetworkService {

    static let shared = NetworkService()

    private var monitor = NWPathMonitor()
    private(set) var networkStatus: NWPath.Status?

    private init() {
        let queue = DispatchQueue(label: "Monitor")

        monitor.pathUpdateHandler = { path in
            self.networkStatus = path.status
            if path.status == .satisfied {
                print("NetworkService: connected")
            } else {
                print("❌ NetworkService: no connection")
            }
        }
        monitor.start(queue: queue)
    }

}
