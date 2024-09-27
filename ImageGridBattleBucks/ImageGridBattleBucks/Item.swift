//
//  Item.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
