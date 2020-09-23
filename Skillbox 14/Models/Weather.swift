//
//  Weather.swift
//  Skillbox 14
//
//  Created by Nataliia on 20.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation
import RealmSwift

class Weather: Object {
    @objc dynamic var nameTown =  ""
    @objc dynamic var date = ""
    @objc dynamic var temp = 0.0
    @objc dynamic var feelsLike =  0.0
    
    convenience init?(data: NSDictionary){
        self.init()
        guard let nameTown = data["name"] as? String,
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

class WeatherRealmModel{
    
    static let shared = WeatherRealmModel()
    private let realm = try! Realm()
    var incomingWeatherItems: Weather? = nil
    
    func getAllWeatherItems() -> [Weather] {
        var arrayItems: [Weather] = []
        for item in realm.objects(Weather.self) {
            arrayItems.append(item)
        }
        return arrayItems
    }
    
    func saveWeatherItem(town: String, date: String, temp: Int, feelsLike: Int) {
        let weather = Weather()
        weather.nameTown = town
        weather.date = date
        weather.temp = Double(temp)
        weather.feelsLike = Double(feelsLike)
        try! realm.write {
            realm.add(weather)
        }
    }
}
