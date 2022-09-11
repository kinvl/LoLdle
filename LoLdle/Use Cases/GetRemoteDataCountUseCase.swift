//
//  GetRemoteDataCountUseCase.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 10/09/2022.
//

import Foundation
import RxSwift

protocol GettingRemoteDataCountUseCase {
    /// Get the number of data on a remote server that is used in the application.
    /// - Returns: Dictionary with key `champions`, which contain the number of said objects in a remote database.
    func execute() -> Single<[String: Int]>
}

final class GetRemoteDataCountUseCase: GettingRemoteDataCountUseCase {
    private let service: DataService
    private let repository: DataRepository
    
    // MARK: - Initialization
    init(service: DataService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }
    
    // MARK: - GettingRemoteDataCountUseCase
    func execute() -> Single<[String: Int]> {
        return service.dataCount().flatMap { [weak self] response in
            guard let self = self else { return .error(LoLdleError.downloadFailed) }
            
            return self.repository.handleDataCount(response: response)
        }
    }
}
