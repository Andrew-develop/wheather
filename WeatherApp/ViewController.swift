//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sergio Ramos on 07/07/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    var city = ""
    
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
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["London", "Moscow", "Tomsk", "Sochi", "Madrid"]
    }
    
    
    @IBAction func okButton(_ sender: UIButton) {
        AF.request("http://api.weatherstack.com/current?access_key=45b333bfd48cc2c5a61bfef1be84f46a&query=\(city)").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let posts = Post.getArray(from: value) else { return }
                print(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        AF.request("http://api.weatherstack.com/current?access_key=45b333bfd48cc2c5a61bfef1be84f46a&query=\(searchBar.text)").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let posts = Post.getArray(from: value) else { return }
                print(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
}

