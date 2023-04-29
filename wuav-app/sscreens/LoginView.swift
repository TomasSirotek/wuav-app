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
        ZStack {
            VStack{
                ControlButton(image: Image("arrow"))
                
                Text("Welcome back")
            }
            
            VStack{
                TextField("Email "
                          , text: $email).padding()
                    .frame(width: 300,height: 50)
                    .font(.title2)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.05))
                    .shadow(color: Color.black.opacity(0.08),radius: 60,x: 0.0,y:16)
                
                SecureField("Password", text: $password)
                    .frame(width: 300,height: 50)
                    .font(.title2)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.05))
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.08),radius: 60,x: 0.0,y:16)
                
                
                NavigationLink("Login") {
                    
                    DashboardView()
                    
                    
                }.font(.title3)
                    .padding()
                    .frame(width: 330)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .shadow(color: Color.black.opacity(0.08),radius: 60,x:0.0,y:16)
            }
        }
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
