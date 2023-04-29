//
//  CustomButton.swift
//  wuav-app
//
//  Created by Simko Tomas on 29/04/2023.
//

import SwiftUI

struct Button: View {
    var title: String
    var color: Color?
    var fColor: Color?
    var padding: CGFloat?
    var borderColor: Color?
    var borderWidth: CGFloat?
    var buttonWidth: CGFloat?
    
    var body: some View {
        Text(title)
            .font(.title3)
            .padding()
            .frame(width: buttonWidth)
            .background(color)
            .cornerRadius(5)
            .padding(.horizontal)
            .foregroundColor(fColor)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor ?? Color.clear, lineWidth: borderWidth ?? 0)
            )
            .shadow(color: Color.black.opacity(0.08),radius: 60,x:0.0,y:16)
        
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(title: "Sample Button", color: Color.blue, fColor: Color.white)
    }
}
