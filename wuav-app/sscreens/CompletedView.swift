//
//  CompletedView.swift
//  wuav-app
//
//  Created by Simko on 30/04/2023.
//

import SwiftUI

struct CompletedView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color("PrimaryColor"))
            
            Text("You are almost done !")
                .font(.system(size:25)).bold()
            Text("Check your desktop application")
                .font(.system(size:25))
            
            //     NavigationLink {
            //         WelcomeScreenView()
            //       } label: {
            //           Label("Go back to scanning", systemImage: "qrcode.viewfinder")
            //       }
            //
            //       .font(.title3)
            //       .padding()
            //       .frame(width: 330)
            //       .background(Color("PrimaryColor"))
            //       .cornerRadius(5)
            //       .padding(.horizontal)
            //       .foregroundColor(Color.white)
            //         }
        }
    }
    
    struct CompletedView_Previews: PreviewProvider {
        static var previews: some View {
            CompletedView(path: .constant(NavigationPath()))
        }
    }
}
