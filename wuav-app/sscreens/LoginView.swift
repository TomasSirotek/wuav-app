//
//  LoginView.swift
//  wuav-app
//
//  Created by Simko Tomas
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = "" // default empty
    @State private var password: String = ""
    @State private var wrongEmail: Int = 0
    @State private var wrongPassword: Int = 0
    @State private var showingLoginScreen  = false;
    
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    ControlButton(image: Image("arrow"))
                    
                    
                }.padding(.leading, 30)
                
                Spacer()
            }
            .padding(.top)
            
            
           
            
            VStack {
                HStack {
                    Text("Welcome back !")
                        .font(.system(size: 40))
                        .bold()
                    Spacer()
                }
            }.frame(width: 300, height: 200)
         
           
            
           
            
            
            
            VStack(spacing: 20) {
                TextField("Email ", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .font(.title2)
                  
                    .background(Color.black.opacity(0.05))
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .font(.title2)
                    .background(Color.black.opacity(0.05))
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                
                NavigationLink("Login") {
                    DashboardView()
                }
                .font(.title3)
                .padding()
                .frame(width: 300)
                .background(Color("PrimaryColor"))
                .cornerRadius(5)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
            }
            
            //  Spacer() // Add another Spacer to push VStack to the center
            
            Image("wuav-logo")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
                .offset(y: UIScreen.main.bounds.height / 4.5)
            
            Spacer()
            
        }
        .padding(.horizontal)
        
        
    }
    
    func authenticateUser() -> Bool{
        return false;
    }
    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
