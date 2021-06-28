//
//  MainView.swift
//  UnitConversion
//
//  Created by CJ Gaspari on 6/27/21.
//

import SwiftUI

struct MainView: View {
    
    var sideBar: some View {
        List {
            Group {
                NavigationLink(destination: TemperatureView()) {
                    Label("Temperature", systemImage: "thermometer")
                }
                NavigationLink(destination: LengthConversionView()) {
                    Label("Length", systemImage: "ruler")
                }
            }
        }
        .navigationTitle("Convert")
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        NavigationView {
            sideBar
            ContentView()
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
