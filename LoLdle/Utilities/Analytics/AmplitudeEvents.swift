//
//  AmplitudeEvents.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 29/10/2022.
//

import Foundation

class Event {
    let type: String
    let properties: [AnyHashable : Any]?
    
    init(type: String, properties: [AnyHashable : Any]? = nil) {
        self.type = type
        self.properties = properties
    }
}

// MARK: - Amplitude events
class AnswerChecked: Event {
    init(answerCorrect: Bool) {
        super.init(type: "Answer Checked",
                   properties: ["answer correct": answerCorrect])
    }
}

class ChampionChallengeTapped: Event {
    init() {
        super.init(type: "Champion Challenge Tapped")
    }
}

class ErrorViewed: Event {
    init(errorDescription: String, errorCode: Int) {
        super.init(type: "Error Viewed",
                   properties: [
                    "error description": errorDescription,
                    "error code": errorCode
                   ])
    }
}
