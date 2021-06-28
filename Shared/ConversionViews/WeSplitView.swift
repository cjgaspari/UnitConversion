//
//  ContentView.swift
//  WeSplit
//
//  Created by CJ Gaspari on 6/25/21.
//

import SwiftUI

struct WeSplitView: View {
    @State private var checkAmount: Double?
    @State private var numberOfPeople: Double?
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]
    
    private var currencyFormatter: NumberFormatter = {
            let f = NumberFormatter()
            // allow no currency symbol, extra digits, etc
            f.isLenient = true
            f.numberStyle = .currency
            return f
        }()
    
    var total: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount ?? 0)
        
        let tipValue = orderAmount/100 * tipSelection
        let total = orderAmount + tipValue

        return total
    }
    
    var totalPerPerson: Double {
        //calculate total per person
        let peopleCount = Double(numberOfPeople ?? 0)
        
        if(peopleCount > 0) {
            return total/peopleCount
        }
        
        return 0
    }
    
    var body: some View {
        Form {
            Section (header: Text("Amount")){
                //Switched TextField from "text" to "value" and using the currencyFormatter
                //Found via https://github.com/nsscreencast/397-swiftui-tip-calculator/blob/master/TipCalculator/TipCalculator/ContentView.swift
                //I didnt like having the data stored as text, to be converted.
                //This allows to store the data as expected, as optional Double
                #if os(iOS)
                TextField("$0.00", value: $checkAmount, formatter: currencyFormatter)
                    .keyboardType(.decimalPad)
                #else
                TextField("$0.00", value: $checkAmount, formatter: currencyFormatter)
                #endif
                
            }
            
            Section(header: Text("Number of people")) {
                #if os(iOS)
                TextField("2", value: $numberOfPeople, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                #else
                TextField("2", value: $numberOfPeople, formatter: NumberFormatter())
                #endif
            }
            
            //Section header is neat
            Section(header: Text("How much would you like to tip?")) {
                Picker("", selection: $tipPercentage) {
                    ForEach(0 ..< tipPercentages.count) { percentage in
                        Text("\(self.tipPercentages[percentage])%")
                    }
                }
                //Using the SegmentedPickerStyle offers nice inline choices
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section (header: Text("Check total:")) {
                Text("$\(total, specifier: "%.2f")")
            }
            
            Section (header: Text("Amount per person")){
                Text("$\(totalPerPerson, specifier: "%.2f")")
                    .bold()
            }
        }
    }
}

struct WeSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}
