//
//  DatabaseManager.swift
//  WeatherApp
//
//  Created by Ярослав on 10/22/20.
//

import Foundation
import RealmSwift

class DatabaseManager {
    
    static let sharedInstance: DatabaseManager = {
        return DatabaseManager()
    }()
    
    private init() { }
    
    let realm: Realm = try! Realm()
    
    func saveWeatherModel(_ weatherModel: WeatherModel) {
        let weatherRealmModel: WeatherRealmModel = WeatherModelTransformer.sharedInstance.transformToWeatherRealmModel(weatherModel)
        do {
            try realm.write() {
                if (realm.object(ofType: WeatherRealmModel.self, forPrimaryKey: weatherRealmModel.city) == nil) {
                    realm.add(weatherRealmModel)
                }
            }
        } catch {
            printError(error)
        }
    }
    
    func getWeatherModels() -> [WeatherRealmModel] {
        var weatherRealmModels: [WeatherRealmModel] = []
        realm.objects(WeatherRealmModel.self).forEach { weatherRealmModel in
            weatherRealmModels.append(weatherRealmModel)
        }
        return weatherRealmModels
    }
}


