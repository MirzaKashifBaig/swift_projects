//
//  DifferentCitiesDetailView.swift
//  Weather_API_JSON
//
//  Created by Mirza Baig on 14/09/22.
//

import SwiftUI

struct DifferentCitiesDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var cityDataArray: [CityNames]
    
    @State private var cityField = 0
    var cityName:[CityNames] = []
    
    var body: some View {
        NavigationView {
            Form{
                VStack(alignment: .leading){
                    Text("Select City")
                    Picker("Select City", selection: $cityField){
                        ForEach(0..<cityName.count, id:\.self) { index in
                            Text(cityName[index].name)
                                .tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .toolbar{
                Button(action: {
                    let arrayContains = cityDataArray.contains(cityName[cityField])
                    if arrayContains != true {
                        cityDataArray.append(cityName[cityField])
                        dismiss()
                    }
                    else{
                        print("Already inside array")
                    }
                }, label: {
                    Label("Add City", systemImage: "plus")
                        .labelStyle(.iconOnly)
                })
            }
        }
    }
    
    
    init(cityNames: [CityNames], cityArray: Binding<[CityNames]>){
        // MARK: Filled with json Data
        self.cityName = cityNames
        
        
        self._cityDataArray = cityArray
    }
    
}

//struct DifferentCitiesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DifferentCitiesDetailView(cityNames: [])
//    }
//}
