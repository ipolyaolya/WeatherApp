//
//  MainJSON.swift
//  Weather
//
//  Created by olli on 07.05.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import Foundation

struct Main: Decodable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var seaLevel: Double
    var grndLevel: Double
    var humidity: Int
    var tempKf: Double

    enum MainKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MainKeys.self)
        
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
        self.tempMax = try container.decode(Double.self, forKey: .tempMax)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.seaLevel = try container.decode(Double.self, forKey: .seaLevel)
        self.grndLevel = try container.decode(Double.self, forKey: .grndLevel)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.tempKf = try container.decode(Double.self, forKey: .tempKf)
    }
}
