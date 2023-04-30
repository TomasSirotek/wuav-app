//
//  ContentView.swift
//  wuav-app

import SwiftUI

// Need to fix the black and white mode
// Do not forget to hide the navigation .navigationBarHidden(true)
struct ContentView: View {
    var body: some View {
        NavigationStack{
           // WelcomeScreenView()
            DashboardView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ControlButton: View {
    var image: Image
    
    var body: some View {
        HStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 44)
        }
        .buttonStyle(PlainButtonStyle())
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0)
        )
      //  .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}


