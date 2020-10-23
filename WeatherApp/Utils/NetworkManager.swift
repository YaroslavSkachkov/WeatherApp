//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Ярослав on 10/22/20.
//

import Foundation

class NetworkManager {
    
    let apiKey: String
    var timer: Timer?
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func requestWeatherForLocation(city: String, country: String, completion: @escaping (WeatherModel?)->()) {
        if timer == nil {
            let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city),\(country)&appid=\(apiKey)&units=metric"
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    printError(error!)
                    return
                }
                do {
                    let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                    DispatchQueue.main.async {
                        DatabaseManager.sharedInstance.saveWeatherModel(weatherModel)
                        completion(weatherModel)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    printError(error)
                }
            }).resume()
            stopRequests()
        } else {
            completion(nil)
        }
    }
    
    private func stopRequests() {
        timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(invalidateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func invalidateTimer() {
        self.timer?.invalidate()
        timer = nil
    }
    
}
