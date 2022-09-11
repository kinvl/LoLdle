//
//  URLProvider.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 01/09/2022.
//

import Foundation

protocol DirectoryURLProviding {
    var championIconsDirectory: URL? { get }
}

class DirectoryURLProvider: DirectoryURLProviding {
    private let championsIconsFolder = "ChampionIcons"
    private let fileManager: FileManager
    
    // MARK: - Initialization
    init() {
        fileManager = FileManager.default
    }
    
    // MARK: - URLProviderProtocol
    var championIconsDirectory: URL? {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return pathFor(folder: championsIconsFolder, in: documentsDirectory)
    }
    
    // MARK: - Private
    private func pathFor(folder: String, in directory: URL) -> URL? {
        let folderPath = directory.appendingPathComponent(folder)
        
        return fileManager.fileExists(atPath: folderPath.absoluteString)
            ? folderPath
            : createDirectory(for: folderPath)
    }
    
    private func createDirectory(for path: URL) -> URL? {
        do {
            try self.fileManager.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
            return path
        } catch {
            return nil
        }
    }
}
