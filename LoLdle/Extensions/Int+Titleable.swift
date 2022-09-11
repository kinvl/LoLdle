//
//  Int.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 08/10/2022.
//

extension Int: Titleable {
    public typealias RawValue = Int
    
    public var rawValue: Int {
        return self
    }
    
    public init?(rawValue: Self.RawValue) {
        self.init(rawValue)
    }
    
    var title: String {
        return String(self)
    }
}
