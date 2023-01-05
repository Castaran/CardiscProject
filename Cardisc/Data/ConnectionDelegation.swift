//
//  ConnectionDelegation.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 05/01/2023.
//

import Foundation
import SignalRClient

class ConnectionDelegation: HubConnectionDelegate {
    private let apiService = ApiService()
    @Published var isReconnecting: Bool = false
    
    func connectionDidReconnect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let body: [String: AnyHashable] = [
                "connectionId": UserDefaults.standard.string(forKey: "connectionId"),
            ]

            self.apiService.httpRequestWithoutReturn(body: body, url: "joinGrp", httpMethod: "POST")
            self.isReconnecting = false
        }
    }
    
    func connectionWillReconnect(error: Error) {
        self.isReconnecting = true
    }
    
    func connectionDidOpen(hubConnection: SignalRClient.HubConnection) { }
    
    func connectionDidFailToOpen(error: Error) { }
    
    func connectionDidClose(error: Error?) { }
    
    func didReceiveData(data: Data) { }

}
