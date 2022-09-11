//
//  DataRepository.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 10/09/2022.
//

import Foundation
import RxSwift

protocol DataRepository {
    func handleDataCount(response: Data) ->  Single<[String: Int]>
    func handleChampionsData(response: Data) -> Single<ChampionsData>
    func handleChallengeSecret(response: Data) -> Single<ChallengeSecret>
}

extension PersistentStorageRepository: DataRepository {
    func handleDataCount(response: Data) -> Single<[String: Int]> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(LoLdleError.unknown))
                return Disposables.create()
            }
            
            do {
                let dataCount = try self.jsonDecoder.decode([String: Int].self, from: response)
                single(.success(dataCount))
            } catch {
                single(.failure(LoLdleError(error: error)))
            }
            
            return Disposables.create()
        }
    }
    
    func handleChampionsData(response: Data) -> Single<ChampionsData> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(LoLdleError.unknown))
                return Disposables.create()
            }
            
            do {
                let championsData = try self.jsonDecoder.decode(ChampionsData.self, from: response)
                single(.success(championsData))
            } catch {
                single(.failure(LoLdleError(error: error)))
            }
            
            return Disposables.create()
        }
    }
    
    func handleChallengeSecret(response: Data) -> Single<ChallengeSecret> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(LoLdleError.unknown))
                return Disposables.create()
            }
            
            do {
                let challengeSecret = try self.jsonDecoder.decode(ChallengeSecret.self, from: response)
                single(.success(challengeSecret))
            } catch {
                single(.failure(LoLdleError(error: error)))
            }
            
            return Disposables.create()
        }
    }
}

