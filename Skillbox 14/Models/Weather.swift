//
//  Weather.swift
//  Skillbox 14
//
//  Created by Nataliia on 20.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation

class Weather: Codable {
    
    let nameTown: String
    let date: String
    let temp: Double
    let feelsLike: Double
    
    init?(data: NSDictionary){
        guard
            let nameTown = data["name"] as? String,
            let date = data["dt"] as? Int,
            let main = data["main"] as? NSDictionary,
            let temp = main["temp"] as? Double,
            let feelsLike = main["feels_like"] as? Double else { return nil }
        self.temp = temp
        self.nameTown = nameTown
        self.date = "\(date)"
        self.feelsLike = feelsLike
    }
}
