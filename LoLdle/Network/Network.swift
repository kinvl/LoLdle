//
//  Network.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/09/2022.
//

import Foundation
import RxSwift

protocol Networking {
    func get(_ urlString: String) -> Single<Data>
    func post(_ urlString: String) -> Single<Data>
    func download(url: URL) -> Single<URL>
}

final class Network: Networking {
    var apiURL: URL {
        URL(string: "https://loldle-ios.herokuapp.com/")!
    }
    
    private let session: URLSession
    private let storage: PersistentStoring
    
    // MARK: - Initialization
    init(session: URLSession, storage: PersistentStoring) {
        self.session = session
        self.storage = storage
    }
    
    // MARK: - Networking
    func get(_ urlString: String) -> Single<Data> {
        return Single.create { [weak self] single in
            guard let apiURL = self?.apiURL else {
                single(.failure(LoLdleError.networkRequestFailed))
                return Disposables.create()
            }
            
            var request = URLRequest(url: apiURL.appendingPathComponent(urlString))
            request.httpMethod = "GET"
            
            self?.session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    single(.failure(LoLdleError(error: error)))
                    return
                }
                
                single(.success(data))
            }.resume()
            
            return Disposables.create()
        }
    }
    
    func post(_ urlString: String) -> Single<Data> {
        return Single.create { [weak self] single in
            guard let apiURL = self?.apiURL else {
                single(.failure(LoLdleError.networkRequestFailed))
                return Disposables.create()
            }
            
            var request = URLRequest(url: apiURL.appendingPathComponent(urlString))
            request.httpMethod = "POST"
            
            self?.session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    single(.failure(LoLdleError(error: error)))
                    return
                }
                
                single(.success(data))
            }.resume()
            
            return Disposables.create()
        }
    }
    
    func download(url: URL) -> Single<URL> {
        return Single.create { [weak self] single in
            self?.session.downloadTask(with: url) { fileLocaion, response, error in
                guard let fileLocaion = fileLocaion else {
                    single(.failure(LoLdleError(error: error)))
                    return
                }
                
                single(.success(fileLocaion))
            }.resume()
            
            return Disposables.create()
        }
    }
}
