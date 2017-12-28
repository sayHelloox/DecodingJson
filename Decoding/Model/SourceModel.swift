//
//  SourceModel.swift
//  Decoding
//
//  Created by Mr_Xu on 2017/12/15.
//  Copyright © 2017年 Mr_xc. All rights reserved.
//

import Foundation

class SourceModel:NSObject, Codable {
    let id: String
    let name: String
    let category: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case overview = "description"
    }
    
    init(_ id: String, name: String, category: String, overview: String) {
        self.id = id
        self.name = name
        self.category = category
        self.overview = overview
    }
}
