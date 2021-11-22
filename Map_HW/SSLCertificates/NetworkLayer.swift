////
////  NetworkLayer.swift
////  Map_HW
////
////  Created by Maksim Ponomarev on 15.11.2021.
////
//import Network
//import Foundation
//import Alamofire
//
//final class NetworkFactory {
//    
//    private func makeServerTrustPolicyManager() -> ServerTrustPolicyManager {
//        
//        // Найдём все сертификаты в приложении
//        let certificates = ServerTrustPolicy.certificates()
//        
//        // version #2
//        // Если решите использовать публичный ключ, что предпочтительнее,
//        // Политика доверия: доверять серверам с найденными ключами
//        let serverTrustPolicy = ServerTrustPolicy.pinPublicKeys( publicKeys: publicKeys,
//        validateCertificateChain: true, validateHost: true
//        )
//        
//        // version #1
//        // Политика доверия: доверять серверам с найденными сертификатами
////        let serverTrustPolicy = ServerTrustPolicy.pinCertificates( certificates: certificates,
////                                                                   validateCertificateChain: true,
////                                                                   validateHost: true )
//        
//        
//        // Применим политику доверия к серверу https://example.com
//        let serverTrustPolicies = ["https://apple.com": serverTrustPolicy]
//        
//        // Создадим менеджер политик безопасности на основе настроек
//        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
//        return serverTrustPolicyManager
//    }
//    
//    private func makeSessionManager() -> SessionManager {
//        let policies = makeServerTrustPolicyManager()
//        let configuration = URLSessionConfiguration.default
//        let manager = SessionManager( configuration: configuration, serverTrustPolicyManager: policies )
//        return manager
//    }
//    
//    
//}
