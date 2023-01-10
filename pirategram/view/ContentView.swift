//
//  ContentView.swift
//  pirategram
//
//  Created by Eddie Wei on 1/8/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    @State var user: User = MissingUser()
    @State var bio = "no user"
    
    var body: some View {
        VStack {
            Image("jackSparrow")
            
            Text(bio)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
