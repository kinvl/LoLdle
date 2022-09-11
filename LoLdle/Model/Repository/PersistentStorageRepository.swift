//
//  PersistentStorageRepository.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation
import Realm
import RealmSwift

protocol PersistentStoring {
    func save<Object: RealmSwiftObject>(_ objects: [Object], update: Realm.UpdatePolicy, completion: (Error?) -> Void)
    func object<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element?
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element>
    func moveFile(from location: URL, to destination: URL) throws
    func fileCount(in directory: URL) throws -> Int
}

final class PersistentStorageRepository: PersistentStoring {
    let jsonDecoder: JSONDecoder
    private let realmStorage: RealmStoring
    private let userDefaultsStorage: UserDefaultsStoring
    private let filesStorage: FilesStoring
    
    // MARK: - Initialization
    init(realmStorage: RealmStoring, userDefaultsStorage: UserDefaultsStoring, filesStorage: FilesStoring) {
        jsonDecoder = JSONDecoder()
        self.realmStorage = realmStorage
        self.userDefaultsStorage = userDefaultsStorage
        self.filesStorage = filesStorage
    }
    
    // MARK: - PersistentStoring
    func save<Object: RealmSwiftObject>(_ objects: [Object], update: Realm.UpdatePolicy, completion: (Error?) -> Void) {
        realmStorage.save(objects, update: update, completion: completion)
    }
    
    func object<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element? {
        realmStorage.object(ofType: type, forPrimaryKey: key)
    }
    
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        realmStorage.objects(type)
    }
    
    func moveFile(from location: URL, to destination: URL) throws {
        try filesStorage.moveFile(from: location, to: destination)
    }
    
    func fileCount(in directory: URL) throws -> Int {
        try filesStorage.fileCount(in: directory)
    }
}
