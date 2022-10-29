//
//  Analytics.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 29/10/2022.
//

import Amplitude
import Foundation

private enum ApiKeys {
    case development
    case production
    
    var environmentVariableKey: String {
        switch self {
        case .development:
            return "AMPLI_DEV_APIKEY"
        case .production:
            return "AMPLI_PROD_APIKEY"
        }
    }
}

final class Analytics {
    static let shared = Analytics()
    
    // MARK: - Initialization
    private init() {}
    
    func setup() {
        Amplitude.instance().trackingSessionEvents = true
        var apiKey: String
        
        #if DEBUG
        apiKey = ProcessInfo.processInfo.environment[ApiKeys.development.environmentVariableKey] ?? ""
        #else
        apiKey = ProcessInfo.processInfo.environment[ApiKeys.production.environmentVariableKey] ?? ""
        #endif
        
        Amplitude.instance().initializeApiKey(apiKey)
        
        let trackingOptions = AMPTrackingOptions()
            .disableIPAddress()
            .disableCarrier()
            .disableIDFA()
            .disableIDFV()
            .disableDMA()
            .disableCity()
            .disableRegion()
            .disableLatLng()
        
        Amplitude.instance().setTrackingOptions(trackingOptions!)
    }
    
    // MARK: - Private
    private func track(_ event: Event) {
        Amplitude.instance().logEvent(event.type, withEventProperties: event.properties)
    }
    
    // MARK: - Amplitude events
    func trackAnswerChecked(answerCorrect: Bool) {
        track(AnswerChecked(answerCorrect: answerCorrect))
    }
    
    func trackChampionChallengeTapped() {
        track(ChampionChallengeTapped())
    }
    
    func trackErrorViewed(errorDescription: String, errorCode: Int) {
        track(ErrorViewed(errorDescription: errorDescription, errorCode: errorCode))
    }
}
