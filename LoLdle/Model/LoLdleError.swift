//
//  LoLdleError.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 12/09/2022.
//

import Foundation

enum LoLdleError: Error {
    case cocoa(description: String)
    case unknown
    case networkRequestFailed
    case downloadFailed
    case databaseFailure
    case cannotReadFile
    
    var description: String {
        switch self {
        case .cocoa(let description):
            return description
        case .unknown:
            return R.string.localizable.error_common_unknown()
        case .networkRequestFailed:
            return R.string.localizable.error_network_common()
        case .downloadFailed:
            return R.string.localizable.error_network_download()
        case .databaseFailure:
            return R.string.localizable.error_database_common()
        case .cannotReadFile:
            return R.string.localizable.error_files_common()
        }
    }
    
    init(error: Error?) {
        guard let error = error else {
            self = .unknown
            return
        }
        
        if let error = (error as? LoLdleError) {
            self = error
            return
        }
        
        self = .cocoa(description: error.localizedDescription)
    }
}
