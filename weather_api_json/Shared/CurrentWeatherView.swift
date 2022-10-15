//
//  CurrentWeatherView.swift
//  Weather_API_JSON
//
//  Created by Mirza Baig on 10/09/22.
//

import SwiftUI

struct CurrentWeatherView: View {
    let weather:WeatherInformation
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height / 15) {
                VStack {
                    Text(Constants.HelperFunctions.fullDateAndYearFormat())
                        .foregroundColor(.white)
                    Text(Date(), style: .time)
                        .foregroundColor(.white)
                        .font(.system(size: 35.0))
                    Text(weather.name)
                        .foregroundColor(.white)
                }
                Image(systemName: weather.weather[0].main.stringValue)
                    .font(.system(size: 190.0))
                    .foregroundColor(.white)
                Text("\(Constants.HelperFunctions.kelvinToCelcius(temp: weather.main.temp)) °C")
                    .font(.system(size: 56.0))
                    .foregroundColor(.white)
                Text(Constants.HelperFunctions.dayNameFormat())
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .frame(width: geometry.size.width,height: geometry.size.height)
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .padding()
    }
    
    
    
}

//struct CurrentWeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentWeatherView()
//    }
//}
