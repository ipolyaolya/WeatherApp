//
//  MapperForJSON.swift
//  Weather
//
//  Created by olli on 07.05.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import Foundation

struct JSONAnswer: Decodable {
    enum CodingKeys: String, CodingKey {
        case list
        case city
    }
    
    let list: [List]
    let city: City
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // парсинг массива List
        self.list = try container.decode([List].self, forKey: .list)
        self.city = try container.decode(City.self, forKey: .city)
    }
}


struct List: Decodable {
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case dt_txt
    }
    
    let weather: [Weather]
    let main: Main
    let dt_txt: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.main = try container.decode(Main.self, forKey: .main)
        self.dt_txt = try container.decode(String.self, forKey: .dt_txt)
    }
}

