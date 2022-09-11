//
//  Reactive.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 27/10/2022.
//

import RxSwift
import AutocompleteField
import UIKit

extension Reactive where Base: AutocompleteField {
    public var suggestions: Binder<[String]> {
        return Binder(self.base) { autocompleteField, suggestions in
            autocompleteField.suggestions = suggestions
        }
    }
}
