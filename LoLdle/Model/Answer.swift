//
//  Answer.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 23/09/2022.
//

import UIKit

enum Answer {
    case correct
    case incorrect
    case partial
    
    var color: UIColor? {
        switch self {
        case .correct:
            return R.color.correct()
        case .incorrect:
            return R.color.incorrect()
        case .partial:
            return R.color.partial()
        }
    }
}
