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
    var temp_max: Double
    var pressure: Double
    var sea_level: Double
    var grnd_level: Double
    var humidity: Int
    var temp_kf: Double

    enum MainKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case temp_max
        case pressure
        case sea_level
        case grnd_level
        case humidity
        case temp_kf
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MainKeys.self)
        
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
        self.temp_max = try container.decode(Double.self, forKey: .temp_max)
        self.pressure = try container.decode(Double.self, forKey: .pressure)
        self.sea_level = try container.decode(Double.self, forKey: .sea_level)
        self.grnd_level = try container.decode(Double.self, forKey: .grnd_level)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.temp_kf = try container.decode(Double.self, forKey: .temp_kf)
    }
}
