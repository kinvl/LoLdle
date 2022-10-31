//
//  StorageAssembly.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Swinject
import Foundation
import RealmSwift

final class StorageAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RealmStoring.self) { resolver in
            let realm = try! Realm()
            return RealmStorage(realm: realm)
        }
        
        container.register(UserDefaultsStoring.self) { resolver in
            let defaults = UserDefaults.standard
            return UserDefaultsStorage(defaults: defaults)
        }
        
        container.register(FilesStoring.self) { resolver in
            let manager = FileManager.default
            return FilesStorage(manager: manager)
        }
    }
}
