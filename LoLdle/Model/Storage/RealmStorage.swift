//
//  RealmStorage.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation
import RealmSwift
import Realm

protocol RealmStoring {
    func save<Object: RealmSwiftObject>(_ objects: [Object], update: Realm.UpdatePolicy, completion: (Error?) -> Void)
    func object<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element?
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element>
}

final class RealmStorage: RealmStoring {
    private let realm: Realm
    
    // MARK: - Initialization
    init(realm: Realm) {
        self.realm = realm
    }
    
    // MARK: - RealmStoring
    func save<Object: RealmSwiftObject>(_ object: Object, update: Realm.UpdatePolicy, completion: (Error?) -> Void) {
        do {
            try realm.write {
                realm.add(object, update: update)
            }
        } catch {
            completion(error)
        }
        
        completion(nil)
    }
    
    func save<Object: RealmSwiftObject>(_ objects: [Object], update: Realm.UpdatePolicy, completion: (Error?) -> Void) {
        do {
            try realm.write {
                objects.forEach { object in
                    realm.add(object, update: update)
                }
            }
        } catch {
            completion(error)
        }
        
        completion(nil)
    }
    
    func object<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element? {
        realm.object(ofType: type, forPrimaryKey: key)
    }
    
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        return realm.objects(type)
    }
}
