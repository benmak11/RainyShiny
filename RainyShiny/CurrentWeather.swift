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
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        // Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request("\(currentWeatherURL)", withMethod: .get).responseJSON() { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                // Grabbing the name of the city here
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                // Grabbing the weather type
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                // Grabbing the current temp
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let curTemp = main["temp"] as? Double {
                        let kelvinToFarenheitPreDivision = (curTemp * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        
                        self._currentTemp = kelvinToFarenheit
                        print(self._currentTemp)
                    }
                }
                
                
            }
            
        }
        completed()
        
    }
}
