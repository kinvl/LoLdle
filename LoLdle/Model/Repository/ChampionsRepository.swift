//
//  ChampionsRepository.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

protocol ChampionsRepository {
    func saveChampions(_ champions: [Champion]) -> Completable
    func saveChampionIcon(url: URL, fileName: String) -> Completable
    func getChampion(named name: String) -> Champion?
    func getAllChampions() -> Single<[Champion]>
    func getAllChampionsNames() -> Single<[String]>
    func getChampionsIconCount() -> Single<Int>
    func getChampionIcon(id: Int?) throws -> UIImage?
}

extension PersistentStorageRepository: ChampionsRepository {
    func saveChampions(_ champions: [Champion]) -> Completable {
        return Completable.create { [weak self] completable in
            let championObjects = champions.map { $0.mapToObject() }
            
                self?.save(championObjects, update: .modified) { error in
                    if let error = error {
                        completable(.error(LoLdleError(error: error)))
                        return
                    }
                    
                    completable(.completed)
                }
            
            return Disposables.create()
        }
    }
    
    func saveChampionIcon(url: URL, fileName: String) -> Completable {
        return Completable.create { [weak self] completable in
            let iconsDirectory = DirectoryURLProvider().championIconsDirectory!
            let finalPath = iconsDirectory.appendingPathComponent(fileName)
            
            do {
                try self?.moveFile(from: url, to: finalPath)
                completable(.completed)
            } catch {
                (error as NSError).code == 516
                ? completable(.completed)
                : completable(.error(LoLdleError(error: error)))
            }
            
            return Disposables.create()
        }
    }
    
    func getChampion(named name: String) -> Champion? {
        return object(ofType: ChampionObject.self, forPrimaryKey: name)?.mapToDomain()
    }
    
    func getAllChampions() -> Single<[Champion]> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(LoLdleError.databaseFailure))
                return Disposables.create()
            }
            
            let champions = Array(self.objects(ChampionObject.self)).map { $0.mapToDomain() }
            
            single(.success(champions))
            
            return Disposables.create()
        }
    }
    
    func getAllChampionsNames() -> Single<[String]> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(LoLdleError.databaseFailure))
                return Disposables.create()
            }
            
            single(.success(Array(self.objects(ChampionObject.self)).map { $0.name }))
            
            return Disposables.create()
        }
    }
    
    func getChampionsIconCount() -> Single<Int> {
        return Single.create { [weak self] single in
            guard let self = self,
                  let iconsDirectory = DirectoryURLProvider().championIconsDirectory else {
                single(.failure(LoLdleError.databaseFailure))
                return Disposables.create()
            }
            
            do {
                let count = try self.fileCount(in: iconsDirectory)
                single(.success(count))
            } catch {
                single(.failure(LoLdleError.cannotReadFile))
            }
            
            return Disposables.create()
        }
    }
    
    func getChampionIcon(id: Int?) throws -> UIImage? {
        guard let id = id else { return nil }
        let url = (DirectoryURLProvider().championIconsDirectory)!.appendingPathComponent("\(id).jpg")
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    }
}
