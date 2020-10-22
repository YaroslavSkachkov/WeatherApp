//
//  WeatherModelTransformer.swift
//  WeatherApp
//
//  Created by Ярослав on 10/22/20.
//

import Foundation

class WeatherModelTransformer {
    
    static let sharedInstance: WeatherModelTransformer = {
        return WeatherModelTransformer()
    }()
    
    private init() { }
    
    func transformToWeatherRealmModel(_ weatherModel: WeatherModel) -> WeatherRealmModel {
        let weatherRealmModel: WeatherRealmModel = WeatherRealmModel()
        weatherRealmModel.city = weatherModel.name ?? ""
        weatherRealmModel.temp = weatherModel.main?.temp ?? 0.0
        weatherRealmModel.desc = weatherModel.weather[0]?.desc ?? ""
        return weatherRealmModel
    }
    
}
