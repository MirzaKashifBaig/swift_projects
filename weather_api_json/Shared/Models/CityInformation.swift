//
//  CityInformation.swift
//  Weather_API_JSON
//
//  Created by Mirza Baig on 12/09/22.
//

import SwiftUI

struct WeatherInformation: Codable, Hashable{
    
    let name: String
    let id: Int
    let main: Main
    let weather:[Weather]
    
    
    struct Main: Codable, Hashable{
        let temp: Double
    }
    
    struct Weather: Codable, Hashable{
        let id:Int
        let main: WeatherConditionTypes
        let description: String
        let icon: String
    }
    
    enum WeatherConditionTypes: String, Codable{
        case Thunderstrom, Drizzle,Rain,Snow,Atmosphere,Clear,Clouds
        var stringValue: String{
            switch self{
            case .Thunderstrom:
                return "cloud.bolt"
            case .Drizzle:
                return "cloud.drizzle.fill"
            case .Rain:
                return "cloud.drizzle.fill"
            case .Snow:
                return "cloud.snow.fill"
            case .Atmosphere:
                return "sun.dust"
            case .Clear:
                return "sun.max.fill"
            case .Clouds:
                return "smoke.fill"
            }
        }
        
        var gradientValue: Color{
            switch self {
            case .Thunderstrom:
                return .purple
            case .Drizzle:
                return .gray
            case .Rain:
                return .blue
            case .Snow:
                return .pink
            case .Atmosphere:
                return .brown
            case .Clear:
                return .cyan
            case .Clouds:
                return .orange
            }
        }
    }
    
}
