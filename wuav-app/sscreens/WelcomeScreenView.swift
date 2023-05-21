//
//  WelcomeScreenView.swift
//  wuav-app
//
//  Created by Simko Tomas on 29/04/2023.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {

    
      
        VStack {
            ZStack {
                Image("main-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6)
                    .clipped()
                    .edgesIgnoringSafeArea(.top)
                
                Image("wuav-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
                    .offset(y: UIScreen.main.bounds.height / 4.5)
                Spacer()
            }
            
            
            NavigationLink("Get started") {
                
            }
            .font(.title3)
            .padding()
            .frame(width: 330)
            .background(Color(.black))
            .cornerRadius(5)
            .padding(.horizontal)
            .foregroundColor(Color.white)
            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
            
          //   NavigationLink("Scan", destination: ScanView())
            
           
            .font(.title3)
            .padding()
            .frame(width: 330)
            .background(Color("PrimaryColor"))
            .cornerRadius(5)
            .padding(.horizontal)
            .foregroundColor(Color.white)
            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
            
            Spacer()
            Text("Continue as quest").underline()
            
        }.padding(.horizontal)
    }
    
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
