//
//  CompletedView.swift
//  wuav-app
//
//  Created by Simko on 30/04/2023.
//

import SwiftUI

struct CompletedView: View {
    var body: some View {
        VStack(spacing: 30) {
                  Image(systemName: "checkmark")
                      .resizable()
                      .frame(width: 100, height: 100)
                      .foregroundColor(.green)

                  Text("Check your desktop application")
                      .font(.title)

                  Button(action: {
                      // Go back to all projects
                  }) {
                      Text("Get back to all projects")
                          .padding()
                          .background(Color.blue)
                          .foregroundColor(.white)
                          .cornerRadius(10)
                  }
              }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView()
    }
}
