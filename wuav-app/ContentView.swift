//
//  ContentView.swift
//  wuav-app

import SwiftUI

// Need to fix the black and white mode
// Do not forget to hide the navigation .navigationBarHidden(true)
struct ContentView: View {
    
    @State private var path = NavigationPath();
    @State private var buttonOffset: CGFloat = 0
    
    
    var body: some View {
     
        
        VStack {
            NavigationStack(path: $path) {
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
                    
                    NavigationLink {
                       ArViewPage()
                    } label: {
                        Label("AR Demo", systemImage: "camera.viewfinder")
                    }
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                  .offset(x: buttonOffset, y: 0)
                    .font(.title3)
                    .padding()
                    .frame(width: 330)
                    .background(Color.black)
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    
                    
                    NavigationLink {
                        ScanView(path: $path)
                    } label: {
                        Label("Scan to upload", systemImage: "qrcode.viewfinder")
                    }
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                  .offset(x: buttonOffset, y: 0)
                    .font(.title3)
                    .padding()
                    .frame(width: 330)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                  
        
                    Spacer()
                    Text("Continue as quest").underline()
                    
                }.padding(.horizontal)
            }.navigationBarHidden(true)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




