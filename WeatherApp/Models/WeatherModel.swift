//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ярослав on 10/22/20.
//

import Foundation
import RealmSwift

struct WeatherModel: Codable {
    var coord: Coordinates?
    var weather: [Weather?]
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var id: Int?
    var name: String?
    var cod: Int?
}

struct List: Codable {
    var dt: Int?
    var main: Main?
    var weather: [Weather?]
    var clouds: Clouds?
    var wind: Wind?
    var visibility: Int?
    var pop: Double?
    var rain: Rain?
    var snow: Snow?
    var sys: Sys?
    var dtTxt: String?
}

struct Coordinates: Codable {
    var lon: Double?
    var lat: Double?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var desc: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case desc = "description"
    }
}


struct Main: Codable {
    var temp: Double?
    var feelsLike: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Int?
    var seaLevel: Int?
    var grndLevel: Int?
    var humidity: Int?
    var tempKf: Double?
}

struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}

struct Clouds: Codable {
    var all: Int?
}

struct Sys: Codable {
    var type: Int?
    var id: Int?
    var message: Int?
    var country: String?
    var sunrise: Double?
    var sunset: Double?
}

struct Rain: Codable {
    
}

struct Snow: Codable {
    
}

class WeatherRealmModel: Object {
    @objc dynamic var city: String = ""
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var desc: String = ""
    
    override class func primaryKey() -> String? {
        return "city"
    }
}
