//
//  ModelManager.swift
//  WeatherApp
//
//  Created by Ярослав on 10/22/20.
//

import Foundation

class ModelManager {
    
    func modelFrom(jsonFileName: String, completion: (InfoModel?)->()) {
        let decoder = JSONDecoder()
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let infoModel = try decoder.decode(InfoModel.self, from: data)
                completion(infoModel)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        
    }
    
}
