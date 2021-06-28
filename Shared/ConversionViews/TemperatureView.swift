//
//  TemperatureView.swift
//  UnitConversion
//
//  Created by CJ Gaspari on 6/27/21.
//

import SwiftUI

struct TemperatureView: View {
    @State private var initTemperature: Double? = 75
    @State private var initTempSelection: TemperatureTypes = .Farenheit
    @State private var postTempSelection: TemperatureTypes = .Celcius
    
    private var convertedTemperature: Double {
        let initialTemperatureConvertedToFarenheit: Double
        let initTemp: Double = initTemperature ?? 0
        
        let convertedTemp: Double
        
        //Ideally would like to clean up these two switch statements
        //Converted all initial temperatures to Farenheit first
        switch initTempSelection {
            case .Farenheit :
                initialTemperatureConvertedToFarenheit = initTemp
            case .Celcius :
                initialTemperatureConvertedToFarenheit = (initTemp*1.8)+32
            case .Kelvin :
                initialTemperatureConvertedToFarenheit = (9/5)*(initTemp-273)+32
        }
        
        switch postTempSelection {
            case .Farenheit :
                convertedTemp = initialTemperatureConvertedToFarenheit
            case .Celcius :
                convertedTemp = (initialTemperatureConvertedToFarenheit-32)/1.8
            case .Kelvin :
                convertedTemp = (initialTemperatureConvertedToFarenheit+459.67)*(5/9)
        }
        
        return convertedTemp
    }
    
    //To keep things clean, using an enum for the TemperatureTypes
    enum TemperatureTypes: String, CaseIterable {
        case Farenheit = "Farenheit"
        case Celcius = "Celcius"
        case Kelvin = "Kelvin"
        
        var type: LocalizedStringKey { LocalizedStringKey(rawValue) }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Current Temperature")) {
                #if os(iOS)
                TextField("0", value: $initTemperature, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                #else
                TextField("0", value: $initTemperature, formatter: NumberFormatter())
                #endif
                    
            }
            
            Section(header: Text("What would you like to convert from?")) {
                Picker("", selection: $initTempSelection) {
                    //Found out how to loop over an Enum
                    //https://developer.apple.com/forums/thread/126706
                    ForEach(TemperatureTypes.allCases, id: \.self) { value in
                        Text(value.type)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("What would you like to convert to?")) {
                Picker("", selection: $postTempSelection) {
                    ForEach(TemperatureTypes.allCases, id: \.self) { value in
                        Text(value.type)
                            .tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Result")) {
                //Noticed some irregularities for Kelvin -> Kelvin
                //To be reviewed
                Text("\(convertedTemperature, specifier: "%.2f") \(postTempSelection.rawValue)")
                    .bold()
            }
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}
