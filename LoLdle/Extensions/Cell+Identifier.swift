//
//  Cell+Identifier.swift
//  LoLdle
//
//  Created by Krzysztof Kinal on 23/09/2022.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        String(describing: self)
    }
}
