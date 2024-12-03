//
//  NetworkMonitor.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 02/12/24.
//

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var path: NWPath?
    
    var isConnected: Bool = false
    
    var connectionType: NWInterface.InterfaceType? {
        return getConnectionType(from: path)
    }
    
    private init() {
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] newPath in
            self?.path = newPath
            self?.isConnected = newPath.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    private func getConnectionType(from path: NWPath?) -> NWInterface.InterfaceType? {
        guard let path = path else { return nil }
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .wiredEthernet
        } else {
            return nil
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
