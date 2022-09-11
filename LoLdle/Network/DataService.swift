//
//  DataService.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 10/09/2022.
//

import Foundation
import RxSwift

protocol DataService {
    func dataCount() -> Single<Data>
    func getChampionsData() -> Single<Data>
    func downloadChampionsIcons(urls: [URL]) -> Observable<Single<(URL, String)>>
}

extension Network: DataService {
    var dataCountEndpoint: String {
        "data/count/"
    }
    
    var championsDataEndpoint: String {
        "data/champions/"
    }
    
    // MARK: - DataService
    func dataCount() -> Single<Data> {
        return get(dataCountEndpoint)
    }
    
    func getChampionsData() -> Single<Data> {
        return get(championsDataEndpoint)
    }
    
    func downloadChampionsIcons(urls: [URL]) -> Observable<Single<(URL, String)>> {
        return Observable.create { [weak self] observable in
            guard let self = self else {
                observable.onError(LoLdleError.networkRequestFailed)
                return Disposables.create()
            }
            
            urls.forEach { url in
                let element = self.download(url: url).map({ tempIconURL -> (URL, String) in
                    let fileName = url.deletingLastPathComponent().lastPathComponent + ".jpg"
                    return (tempIconURL, fileName)
                })
                
                observable.onNext(element)
            }
            
            observable.onCompleted()
            
            return Disposables.create()
        }
    }
}
