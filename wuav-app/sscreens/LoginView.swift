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
    @Binding var path: NavigationPath
    
    
    var body: some View {
        
        VStack {
          
            
            VStack {
                HStack {
                    Text("Welcome back !")
                        .font(.system(size: 40))
                        .bold()
                    Spacer()
                }
            }
            
    
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
                
              //   NavigationLink {)
              //       DashboardView()
              //   } label: {
              //       Label("Work Folder", systemImage: "folder")
              //   }
                
                .font(.title3)
                .padding()
                .frame(width: 300)
                .background(Color("PrimaryColor"))
                .cornerRadius(5)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
            }
            
            Image("wuav-logo")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
                .offset(y: UIScreen.main.bounds.height / 4.5)
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    path.removeLast()
                }label: {
                    Image(systemName: "chevron.left.square")
                }
              
            }
        }
      
            
        .padding(.horizontal)
        
        
    }
    
    func authenticateUser() -> Bool{
        return false;
    }
    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginView(path: .constant(NavigationPath()))
        }
     
    }
}
