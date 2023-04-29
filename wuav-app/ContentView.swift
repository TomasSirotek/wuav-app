//
//  ContentView.swift
//  wuav-app

import SwiftUI

// Need to fix the black and white mode
struct ContentView: View {
    
    var body: some View {
        VStack {
            WelcomeScreenView();
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

