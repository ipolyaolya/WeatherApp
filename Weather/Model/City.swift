//
//  City.swift
//  Weather
//
//  Created by olli on 08.05.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import Foundation

struct City: Decodable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

