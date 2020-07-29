//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sergio Ramos on 07/07/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var city = ""
    var cityResponse = ""
    var temperature = 0
    
    let pickerData = ["London", "Moscow", "Tomsk", "Sochi", "Madrid"]
    
    @IBAction func okButton(_ sender: UIButton) {
        AF.request("http://api.weatherstack.com/current?access_key=45b333bfd48cc2c5a61bfef1be84f46a&query=\(city)").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                print("Success got the weather data")
                let weatherJSON : JSON = JSON(responseJSON.value)
                self.updateWeatherData(json: weatherJSON)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateWeatherData(json: JSON) {
        if let tempResults = json["current"]["temperature"].double {
            temperature = Int(tempResults)
            cityResponse = json["location"]["name"].stringValue
            updateUIWithWeatherData()
        }
        else {
            cityLabel.text = "Weather unavailable"
        }
    }
    
    func updateUIWithWeatherData() {
        cityLabel.text = cityResponse
        temperatureLabel.text = String(temperature)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        city = pickerData[row]
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        AF.request("http://api.weatherstack.com/current?access_key=45b333bfd48cc2c5a61bfef1be84f46a&query=\(searchBar.text!)").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                print("Success got the weather data")
                let weatherJSON : JSON = JSON(responseJSON.value)
                self.updateWeatherData(json: weatherJSON)
            case .failure(let error):
                print(error)
            }
        }
    }
}

