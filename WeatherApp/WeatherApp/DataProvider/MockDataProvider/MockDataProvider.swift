//
//  MockDataProvider.swift
//  WeatherApp
//
//  Created by Serhii Mokliuchenko on 23.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation

struct MockDataProvider: DataProvider {
    
    func loadWeather(by name: String, completion: @escaping (CurrentWeatherModel) -> Void) {

        if let url = Bundle.main.url(forResource: "MockDataWeather", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let weather = try decoder.decode(CurrentWeatherModel.self, from: data)
                completion(weather)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
}
