//
//  DashboardView.swift
//  wuav-app
//
//  Created by Simko on 29/04/2023.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var user: String = "Michael" // for now to mock
    
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Hello, " + user).font(.system(size: 40))
                        
                        
                    }
                    
                    Spacer()
                }
                .padding(.top, 60) // Increase the top padding
                .padding(.leading, 60) // Increase the leading (left) padding
                .padding(.trailing, 60) // Increase the trailing (right) padding
                       
                
                Spacer()
                
            }
            
            
            
            
            
            
        }.navigationBarHidden(false) // for now
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
