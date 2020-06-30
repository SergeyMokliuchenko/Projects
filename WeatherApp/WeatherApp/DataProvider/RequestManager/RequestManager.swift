//
//  RequestManager.swift
//  WeatherApp
//
//  Created by Serhii Mokliuchenko on 23.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import Foundation
import Alamofire

protocol DataProvider {
    
    func loadWeather(by name: String, completion: @escaping (CurrentWeatherModel) -> Void)
}

struct RequestManager: DataProvider {

    func loadWeather(by name: String, completion: @escaping (CurrentWeatherModel) -> Void) {
        let url = RequestManagerConstants.baseURL + "data/2.5/weather"
        let params: Parameters = ["q" : name, "units" : RequestManagerConstants.unit, "appid" : RequestManagerConstants.appKey]
        AF.request(url, method: .get, parameters: params).validate().responseDecodable(of: CurrentWeatherModel.self) { (response) in
            guard let weather = response.value else { return }
            completion(weather)
        } 
    }
    
}
