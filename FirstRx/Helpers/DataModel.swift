//
//  DataModel.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/19/20.
//

import Foundation

struct Category: Codable {
    var id: String? = nil
    var name: String? = nil
    var transactionType: String? = nil
    var iconImage: String? = nil
}

struct Song: Codable {
    var albumId: Int? = nil
    var id: Int? = nil
    var title: String? = nil
    var url: String? = nil
    var thumbnailUrl: String? = nil
}
