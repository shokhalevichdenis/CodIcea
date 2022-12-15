//
//  ContentView.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 12/12/22.
//

import SwiftUI


struct ContentView: View {
    
    // Controls display of sidebar
    @State var showSidebar: Bool = false
    
    var body: some View {
           V_MainPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


