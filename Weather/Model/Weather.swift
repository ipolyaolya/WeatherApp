//
//  WeatherJSON.swift
//  Weather
//
//  Created by olli on 07.05.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.main = try container.decode(String.self, forKey: .main)
        self.description = try container.decode(String.self, forKey: .description)
        self.icon = try container.decode(String.self, forKey: .icon)
    }
}
