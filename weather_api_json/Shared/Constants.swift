//
//  Constants.swift
//  Weather_API_JSON
//
//  Created by Mirza Baig on 09/09/22.
//

import Foundation


class Constants {
    struct URLS {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
    }
    
    struct ENDPOINTS {
        static let weather = "/weather?"
    }
    
    struct HelperFunctions {
        static func kelvinToCelcius(temp: Double) -> String {
            return String(format: "%.2f", temp - 273.15)
        }
        
        static func fullDateAndYearFormat() -> String {
            let newDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            
            return dateFormatter.string(from: newDate)
        }
        
        static func dayNameFormat () -> String {
            
            let newDate = Date()
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: newDate)
            
        }
    }
}
