//
//  Answer+CustomOperator.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 23/09/2022.
//

infix operator =?=

extension Collection where Element: RawRepresentable, Element.RawValue == String, Element: Comparable {
    static func =?=(lhs: Self, rhs: Self) -> Answer {
        lhs.count == rhs.count && lhs.sorted() == rhs.sorted()
            ? .correct
            : lhs.contains(where: rhs.contains)
                ? .partial
                : .incorrect
    }
}

extension RawRepresentable where RawValue == String {
    static func =?= (lhs: Self, rhs: Self) -> Answer {
        lhs == rhs ? .correct : .incorrect
    }
}

extension String {
    static func =?= (lhs: String, rhs: String) -> Answer {
        lhs == rhs ? .correct : .incorrect
    }
}

extension Int {
    static func =?= (lhs: Int, rhs: Int) -> Answer {
        lhs == rhs ? .correct : .incorrect
    }
}
