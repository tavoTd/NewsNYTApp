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
    
    var isConnected: Bool {
        return path?.status == .satisfied
    }
    
    var connectionType: NWInterface.InterfaceType? {
        return getConnectionType(from: path)
    }
    
    var onStatusChange: ((Bool) -> Void)?
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] newPath in
            self?.path = newPath
            let isConnected = newPath.status == .satisfied
            DispatchQueue.main.async {
                self?.onStatusChange?(isConnected)
            }
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
