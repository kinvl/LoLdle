//
//  FilesStorage.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 11/09/2022.
//

import Foundation
import RxSwift

protocol FilesStoring {
    func moveFile(from location: URL, to destination: URL) throws
    func fileCount(in directory: URL) throws -> Int 
}

final class FilesStorage: FilesStoring {
    private let manager: FileManager
    
    // MARK: - Initialization
    init(manager: FileManager) {
        self.manager = manager
    }
    
    // MARK: - FilesStoring
    func moveFile(from location: URL, to destination: URL) throws {
        try manager.moveItem(at: location, to: destination)
    }
    
    func fileCount(in directory: URL) throws -> Int {
        try manager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles).count
    }
}
