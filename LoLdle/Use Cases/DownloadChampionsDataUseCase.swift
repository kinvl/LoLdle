//
//  DownloadChampionsDataUseCase.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 11/09/2022.
//

import Foundation
import RxSwift

protocol DownloadingChampionsDataUseCase {
    func execute() -> Completable
}

final class DownloadChampionsDataUseCase: DownloadingChampionsDataUseCase {
    let service: DataService
    let dataRepository: DataRepository
    let championsRepository: ChampionsRepository
    
    // MARK: - Initialization
    init(service: DataService, dataRepository: DataRepository, championsRepository: ChampionsRepository) {
        self.service = service
        self.dataRepository = dataRepository
        self.championsRepository = championsRepository
    }
    
    // MARK: - DownloadingChampionsDataUseCase
    func execute() -> Completable {
        return downloadAndSaveChampionsData()
    }
    
    // MARK: - Private
    private func downloadAndSaveChampionsData() -> Completable {
        return service.getChampionsData()
            .flatMap { [weak self] response -> Single<ChampionsData> in
                guard let self = self else { return .error(LoLdleError.downloadFailed) }
                
                return self.dataRepository.handleChampionsData(response: response)
            }
            .flatMapCompletable { [weak self] championsData in
                guard let self = self else { return .error(LoLdleError.downloadFailed) }
                
                return self.championsRepository.saveChampions(championsData.champions)
                    .subscribe(on: ConcurrentMainScheduler.instance)
                    .andThen(self.downloadAndSaveChampionsIcons(championsData: championsData))
            }
    }
    
    private func downloadAndSaveChampionsIcons(championsData: ChampionsData) -> Completable {
        let iconsURLs = makeFinalIconURLs(baseURLString: championsData.iconURL, champions: championsData.champions)
        
        return service.downloadChampionsIcons(urls: iconsURLs)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .concat()
            .flatMap { [weak self] iconInfo -> Completable in
                guard let self = self else { return .error(LoLdleError.downloadFailed) }
                
                return self.championsRepository.saveChampionIcon(url: iconInfo.0, fileName: iconInfo.1)
            }.asCompletable()
    }
    
    private func makeFinalIconURLs(baseURLString: String, champions: [Champion]) -> [URL] {
        return champions.map { champion in
            let id = String(champion.id)
            let finalURLString = baseURLString.replacingOccurrences(of: "@id", with: id)
            
            return URL(string: finalURLString)!
        }
    }
}
