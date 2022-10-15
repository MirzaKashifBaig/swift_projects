//
//  ContentView.swift
//  Shared
//
//  Created by Mirza Baig on 07/09/22.
//

import SwiftUI



struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    var userLat:String{
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLon:String{
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    @State private var weather: WeatherInformation?
//    @State private var citiesWeather = [WeatherInformation]()
    @State private var citiesWeather: [WeatherInformation] = []
    @State private var updateOn = ""
    
    // MARK: On Appear call this array will be filled with City.json file
    @State private var cityJSONData: [CityNames] = []
    
    
    // MARK: This will be empty array
    @State private var cityInformation: [CityNames] = []
    @State var differentCitySheet = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .top){
                if weather != nil {
                    LinearGradient(colors: [weather!.weather[0].main.gradientValue,.blue], startPoint: .leading, endPoint: .bottomTrailing).ignoresSafeArea()
                }
                else{
                    LinearGradient(colors: [Color("BlueGradient"),.blue], startPoint: .leading, endPoint: .bottomTrailing).ignoresSafeArea()
                }
                VStack{
                    if weather != nil {
                        Text(updateOn)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        TabView{
                            CurrentWeatherView(weather: weather!)
                            ForEach(citiesWeather, id:\.self){ eachCityWeather in
                                CurrentWeatherView(weather: eachCityWeather)
                            }
                        }
                        .tabViewStyle(.page)
                        
                        
                    }
                    else{
                        Spacer()
                        ProgressView()
                           
//                        Text("Loading")
//                            .foregroundColor(.white)
//                            .font(.title2)
//                            .bold()
                        Spacer()
                    }
                }
//                .task {
//                    updateOn = Date().formatted(.dateTime)
//                    if locationManager.locationStatus == .authorizedWhenInUse {
//                        await setupDataAsync(lat: locationManager.lastLocation!.coordinate.latitude, long: locationManager.lastLocation!.coordinate.longitude)
//                    }
//                }
                .onAppear{
                    // TODO: Add Sheet view feature
                    
                    // FIXME: Error in loading file
                
                    
                    // MARK: Local JSON Data in City.json file we read data
                    setupData()
                        //MARK: We Call All Weather Inside Task
                    Task{
                        // MARK:  Current Location
                        if locationManager.lastLocation != nil {
                            weather = await request(lat: Double(userLat)!, long: Double(userLon)!)
                        }
                        // MARK: Weather Of Cities Inside JSON
//                        for cities in cityInformation {
//                            let newWeather = await request(lat: Double(cities.lat!), long: cities.log!)
//                            if newWeather != nil {
//                                citiesWeather.append(newWeather!)
//                            }
//                        }
                    }
                    // MARK: For Taking Current Location every 5 mins
                    if locationManager.locationStatus == .authorizedWhenInUse {
                        let newTimer = Timer.scheduledTimer(withTimeInterval: 60.0 * 5, repeats: true){_ in
                            Task{
                                updateOn = Date().formatted(.dateTime)
                                await setupDataAsync(lat: locationManager.lastLocation!.coordinate.latitude, long: locationManager.lastLocation!.coordinate.longitude)
                                print("Data Called")
                            }
                        }
                        RunLoop.main.add(newTimer, forMode: .common)
                    }
                }
            }
            .toolbar{
                HStack{
                    Button(action: {
                        Task{
                            weather = nil
                            if locationManager.locationStatus == .authorizedWhenInUse {
                                await setupDataAsync(lat: locationManager.lastLocation!.coordinate.latitude, long: locationManager.lastLocation!.coordinate.longitude)
                            }
                        }
                    }, label: {
                        Image(systemName: "arrow.clockwise.circle")
                    })
                    .foregroundColor(.white)
                   
                    Button(action: { differentCitySheet.toggle() }, label: {
                        Image(systemName: "plus")
                    })
                    .foregroundColor(.white)
                    
                }
            }
            .sheet(isPresented: $differentCitySheet){
                DifferentCitiesDetailView(cityNames: cityJSONData, cityArray: $cityInformation)
                    
            }
        }
        .onChange(of: cityInformation){ _ in
            print(cityInformation)
            Task{
                for cities in cityInformation {
                    let newWeather = await request(lat: Double(cities.lat), long: cities.log)
                    if newWeather != nil {
                        let weatherOfCity = citiesWeather.contains(newWeather!)
                        if weatherOfCity != true {
                            citiesWeather.append(newWeather!)
                        }
                    }
                }
            }
        }
    }
    
    func request(lat:Double, long: Double) async -> WeatherInformation? {
        let weatherAppID = "xxxx"
        let dataURL = Constants.URLS.baseURL + Constants.ENDPOINTS.weather + "lat=\(lat)&lon=\(long)&appid=\(weatherAppID)"
        guard let url = URL(string: dataURL) else {fatalError("URL Missing")}
        let urlSession = URLSession.shared
        do {
            let (data,response) = try await urlSession.data(from: url)
                        
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return nil
            }
            
            let weatherInfo = try JSONDecoder().decode(WeatherInformation.self, from: data)
            return weatherInfo
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func setupDataAsync(lat:Double, long:Double) async {
        
        let weatherAppID = "xxxx"
        let dataURL = Constants.URLS.baseURL + Constants.ENDPOINTS.weather + "lat=\(lat)&lon=\(long)&appid=\(weatherAppID)"
        guard let url = URL(string: dataURL) else {fatalError("URL Missing")}
        let urlSession = URLSession.shared
        do {
            let (data,response) = try await urlSession.data(from: url)
                        
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            
            let weatherInfo = try JSONDecoder().decode(WeatherInformation.self, from: data)
            weather = weatherInfo
            //            let celsiusTemp = currentTemp.main.temp - 273.15
            //            temperature = celsiusTemp
            //            name = currentTemp.name
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func setupData() {
        if let jsonURL = Bundle.main.url(forResource: "City", withExtension: "json"){
            let jsonData = try! Data(contentsOf: jsonURL)
            let jsonDecode = JSONDecoder()
            let cityAbout:[CityNames] = try! jsonDecode.decode([CityNames].self, from: jsonData)
            cityJSONData = cityAbout
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
