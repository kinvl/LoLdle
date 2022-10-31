//
//  NetworkAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 16/10/2022.
//

import Swinject
import Foundation

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Networking.self) { resolver in
            let session = URLSession.shared
            let storage = resolver.resolve(PersistentStoring.self)!
            return Network(session: session, storage: storage)
        }
        
        container.register(DataService.self) { resolver in
            return resolver.resolve(Networking.self)! as! DataService
        }
        
        container.register(ChallengeService.self) { resolver in
            return resolver.resolve(Networking.self)! as! ChallengeService
        }
    }
}
