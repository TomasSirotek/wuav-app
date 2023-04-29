//
//  WelcomeScreenView.swift
//  wuav-app
//
//  Created by Simko Tomas on 29/04/2023.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
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
        CustomButton(
            title: "Get Started",
            color: Color.black,
            fColor: Color.white,
            buttonWidth: 300
        ).padding(.vertical)
        
        CustomButton(
            title: "Login",
            color: Color("PrimaryColor"),
            fColor: Color.white,
            buttonWidth: 300

        )
        Spacer()
        Text("Continue as quest").underline()
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
