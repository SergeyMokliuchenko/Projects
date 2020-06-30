//
//  Main+Extension.swift
//  WeatherApp
//
//  Created by Serhii Mokliuchenko on 24.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

extension Main {
    
    var temperatureString: String {
        return String(format: "%.0f", temp)
    }
    
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLike)
    }
}
