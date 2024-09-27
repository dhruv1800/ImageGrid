//
//  GridModel.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import Foundation

struct Photo: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
