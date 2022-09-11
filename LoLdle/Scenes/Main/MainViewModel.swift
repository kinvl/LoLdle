//
//  MainViewModel.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation
import RxSwift

protocol MainViewModeling {
    func checkDataCompatibility() -> Completable
}

class MainViewModel: MainViewModeling {
    private let getRemoteDataCountUseCase: GettingRemoteDataCountUseCase
    private let getLocalDataCountUseCase: GettingLocalDataCountUseCase
    private let downloadChampionsDataUseCase: DownloadingChampionsDataUseCase
    
    // MARK: - Initialization
    init(getRemoteDataCountUseCase: GettingRemoteDataCountUseCase, getLocalDataCountUseCase: GettingLocalDataCountUseCase, downloadChampionsDataUseCase: DownloadingChampionsDataUseCase) {
        self.getRemoteDataCountUseCase = getRemoteDataCountUseCase
        self.getLocalDataCountUseCase = getLocalDataCountUseCase
        self.downloadChampionsDataUseCase = downloadChampionsDataUseCase
    }
    
    // MARK: - MainViewModeling
    func checkDataCompatibility() -> Completable {
        return isDataCompatible()
            .flatMapCompletable { [weak self] isCompatible in
                guard let self = self else { return .error(LoLdleError.downloadFailed) }
                
                return isCompatible
                        ? .empty()
                        : self.downloadData()
            }
    }
    
    // MARK: - Private
    private func isDataCompatible() -> Single<Bool> {
        return getRemoteDataCountUseCase
            .execute()
            .asObservable()
            .withLatestFrom(getLocalDataCountUseCase.execute().asObservable()) { remoteDataCount, localDataCount -> Bool in
                let remoteDataCount = remoteDataCount["champions"]
                
                return  remoteDataCount == localDataCount["champions"] &&
                        remoteDataCount == localDataCount["icons"]
            }.asSingle()
    }
    
    private func downloadData() -> Completable {
        return downloadChampionsDataUseCase.execute()
    }
}
