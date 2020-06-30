//
//  ViewController.swift
//  WeatherApp
//
//  Created by Serhii Mokliuchenko on 23.06.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    private var dataProvider: DataProvider = RequestManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func serchButtonAction(_ sender: UIButton) {
        enterCityViewController()
    }
    
    private func enterCityViewController() {
        let enterCityVC = EnterCityViewController.init()
        enterCityVC.modalPresentationStyle = .overFullScreen
        enterCityVC.modalTransitionStyle = .crossDissolve
        enterCityVC.completion = { [weak self] city in
            self?.updateInterface(location: city)
        }
        present(enterCityVC, animated: true)
    }
    
    private func updateInterface(location: String) {
        dataProvider.loadWeather(by: location) { [weak self] currentWeather in
            self?.locationLabel.text = currentWeather.name
            self?.temperatureLabel.text = currentWeather.main.temperatureString
            self?.feelsLikeTemperatureLabel.text = currentWeather.main.feelsLikeTemperatureString
            self?.weatherIconImageView.image = UIImage(systemName: currentWeather.weather.first!.systemIconNameString)
        }
    }
    
}
