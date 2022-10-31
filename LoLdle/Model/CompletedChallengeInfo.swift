//
//  CompletedChallengeInfo.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 31/10/2022.
//

import UIKit

struct CompletedChallengeInfo {
    let numberOfGuesses: Int
    let icon: UIImage?
    let name: String
    
    struct UserDefaultsKeys {
        static let numberOfGuesses = "NumberOfGuesses"
        static let name = "Name"
        static let id = "Id"
        static let completionDate = "CompletionDate"
    }
}
