//
//  InfoModel.swift
//  WeatherApp
//
//  Created by Ярослав on 10/22/20.
//

import Foundation

struct InfoModel: Codable {
    var cod: String
    var cities: [City]
}

struct City: Codable {
    var name: String
    var country: String
    var desc: String
}
