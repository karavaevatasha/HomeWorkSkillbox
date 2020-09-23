//
//  WeatherViewController.swift
//  Skillbox 14
//
//  Created by Nataliia on 20.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    
    var forecast: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherLoader.shared.delegate = self
        WeatherLoader.shared.loadWeather()
    }
}

extension WeatherViewController: WeatherLoaderDelegate{
    func loaded(forecast weather: Weather) {
        DispatchQueue.main.async {
            self.tempLabel.text = String(format: "%.0f", weather.temp - 273,15) + "°C"
            self.townLabel.text = weather.nameTown
            self.dateLabel.text = DateHelper.shared.convertDate(unix: Double(weather.date) ?? 0).date
            self.feelsLikeLabel.text = "Feels like: " + (String(format: "%.0f", weather.feelsLike - 273,15) + "°C")
        }
    }
}

