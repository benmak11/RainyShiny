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
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        get{
            if _cityName == nil {
                return "no city"
            } else {
                return _cityName
            }
        }
    }
    
    var date: String {
        
        if _date == nil {
            _date = "n date"
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
        
        get{
            if _weatherType == nil {
                return "no weather type"
            } else {
                return _weatherType
            }
        }
    }
    
    var currentTemp: Double {
        
        get{
            if _currentTemp == nil {
                return 0.0
            } else{
                return _currentTemp
            }
        }
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        // Alamofire download
        //let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(CURRENT_WEATHER_URL, method: .get).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                // Grabbing the name of the city here
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    
                }
                
                // Grabbing the weather type
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        
                    }
                }
                
                // Grabbing the current temp
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let curTemp = main["temp"] as? Double {
                        let kelvinToFarenheitPreDivision = (curTemp * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        
                        self._currentTemp = kelvinToFarenheit
                        
                    }
                }
                
            }
            completed()
        }
    }
}
