//
//  ReachabilityManager.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 23/10/2023.
//


import Foundation
import Reachability


final class ReachabilityManager {
    
    // MARK: - Singltone
    static let shared = ReachabilityManager()

    // MARK: - Vars
    private var reachability: Reachability?
    
    // MARK: - Intializer
    private init () {
        reachability = try? Reachability()
    }
    
    // MARK: - Start Notification
    func startNotification() {
        do {
            reachability = try Reachability()
            try reachability?.startNotifier()
        } catch {
            print(error)
            print("Unable to start notifier")
        }
    }
    
    // MARK: - Stop Notification
    func stopNotification() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    // MARK: - Handle Reachability
    func handleReachability(completion: @escaping (_ connection: Reachability.Connection) -> Void){
        NotificationCenter.default.addObserver(forName: .reachabilityChanged, object: reachability, queue: .main) { (notification: Notification) in
            guard let myReachability = notification.object as? Reachability else { return }
            
            switch myReachability.connection {
            case .wifi:
                print("wifi")
                completion(.wifi)
            case .cellular:
                print("cellular")
                completion(.cellular)
            case .unavailable:
                print("unavailable")
                completion(.unavailable)
            case .none:
                print("none")
                completion(.unavailable)
            }
        }
    }
    
}
