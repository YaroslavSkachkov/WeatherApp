//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Ярослав on 10/20/20.
//

import UIKit

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var citiesTable: UITableView!
    
    let modelManager: ModelManager = ModelManager()
    let networkManager: NetworkManager = NetworkManager(apiKey: "eba47effea88b18d5b67eae531209447")
    
    var cities: [City] = []
    var weatherRealmModels: [WeatherRealmModel] = []
    var descriptionTVText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherRealmModels = DatabaseManager.sharedInstance.getWeatherModels()
        self.navigationItem.hidesBackButton = true
        citiesTable.delegate = self
        citiesTable.dataSource = self
        descriptionTVText = descriptionTV.text
        descriptionTV.translatesAutoresizingMaskIntoConstraints = false
        modelManager.modelFrom(jsonFileName: "Cities") { model in
            cities = model?.cities ?? []
        }
        citiesTable.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        expandTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func expandTextView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(expand))
        descriptionTV.addGestureRecognizer(tap)
    }
    
    @objc func expand() {
        let descHeight = descriptionTV.bounds.height.rounded()
        let expandedDescHeight = (UIScreen.main.bounds.height * 0.6).rounded()
        if descHeight != expandedDescHeight {
            let heightConstraint = NSLayoutConstraint(item: descriptionTV!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: expandedDescHeight)
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.deactivateConstraint(with: descHeight)
                NSLayoutConstraint.activate([heightConstraint])
                self?.view.layoutIfNeeded()
            }
        } else {
            let heightConstraint = NSLayoutConstraint(item: descriptionTV!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 128)
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.deactivateConstraint(with: expandedDescHeight)
                NSLayoutConstraint.activate([heightConstraint])
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    private func deactivateConstraint(with constant: CGFloat) {
        let heightConstraint = descriptionTV.constraints.filter { $0.constant == constant && $0.firstAttribute == .height && $0.secondItem == nil}
        NSLayoutConstraint.deactivate(heightConstraint)
    }
    
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell: CityCell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        if !cities.isEmpty {
            let city: String = cities[indexPath.row].name
            let country: String = cities[indexPath.row].country
            cityCell.cityLabel.text = "\(city), \(country)"
        }
        return cityCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city: City = cities[indexPath.row]
        let realmContainsModel = weatherRealmModels.contains(where: { $0.city == city.name })
        if weatherRealmModels.isEmpty || !realmContainsModel {
            networkManager.requestWeatherForLocation(city: city.name, country: city.country) { [weak self] in
                if let weatherModel = $0 {
                    self?.descriptionTV.text = "\(city.desc) Current temperature: \(weatherModel.main?.temp ?? 0.0) ℃. About weather: \(weatherModel.weather[0]?.desc ?? "")."
                } else if $0 == nil && !realmContainsModel {
                    self?.descriptionTV.text = city.desc
                }
            }
        } else {
            let weatherModel = weatherRealmModels.filter { $0.city == city.name}[0]
            descriptionTV.text = "\(city.desc) Current temperature: \(weatherModel.temp) ℃. About weather: \(weatherModel.desc)."
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
