//
//  CurrentWeather.swift
//  RainyShiny
//
//  Created by Baynham Makusha on 9/4/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    //var _highTemp: String!
    
    
    var cityName: String {
        
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String {
        
        if _date == nil {
            _date = ""
        }
        
        // Starting to format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        // Converting the date to string
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Double {
        
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
}
