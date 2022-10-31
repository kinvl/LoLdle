//
//  RepositoryAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PersistentStoring.self) { resolver in
            let realmStorage = resolver.resolve(RealmStoring.self)!
            let userDefaultsStorage = resolver.resolve(UserDefaultsStoring.self)!
            let filesStorage = resolver.resolve(FilesStoring.self)!
            return PersistentStorageRepository(realmStorage: realmStorage, userDefaultsStorage: userDefaultsStorage, filesStorage: filesStorage)
        }
        
        container.register(ChampionsRepository.self) { resolver in
            return resolver.resolve(PersistentStoring.self)! as! ChampionsRepository
        }
        
        container.register(DataRepository.self) { resolver in
            return resolver.resolve(PersistentStoring.self)! as! DataRepository
        }
        
        container.register(ChallengesRepository.self) { resolver in
            return resolver.resolve(PersistentStoring.self)! as! ChallengesRepository
        }
    }
}
