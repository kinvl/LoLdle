//
//  Collection.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 15/10/2022.
//

extension Collection where Element: Titleable {
    func joinTitles(separator: String) -> String {
        self.map { $0.title }
            .joined(separator: separator)
    }
}
