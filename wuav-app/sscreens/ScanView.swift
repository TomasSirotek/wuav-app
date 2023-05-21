//
//  ScanView.swift
//  wuav-app
//
//  Created by simko on 03/05/2023.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    
    @Binding var path: NavigationPath
    @State private var isShowingScanner = false;
    @State private var userId: Int?
    @State private var projectName: String?

    
    var body: some View {
        
        VStack {
            if userId != nil && projectName != nil  {
                UploadView2(userId : userId!,projectName: projectName!,path: $path)
            }else {
                
                ZStack {
                    Image("camera-scan")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6)
                        .clipped()
                        .edgesIgnoringSafeArea(.top)
                    
                    Button{
                        isShowingScanner = true;
                    } label: {
                        Label("Scan QR code",systemImage: "qrcode.viewfinder").font(.system(size: 20)).bold()
                    }
                    .frame(width: 200,height: 60)
                       .background(Color("PrimaryColor"))
                       .cornerRadius(5)
                       .padding(.horizontal)
                       .foregroundColor(Color.white)
                   
                    Spacer()
                }
                
                Image("wuav-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
                    .offset(y: UIScreen.main.bounds.height / 20)
            }
       
                                   
        }.padding(.horizontal)
            .sheet(isPresented: $isShowingScanner){
                CodeScannerView(codeTypes: [.qr], completion: handleScan)
            }
   
        
    }
    
 //
 //   NavigationLink {
 //       ScanView(path: $path)
 //   } label: {
 //       Label("Scan", systemImage: "qrcode.viewfinder")
 //   }
 //
 //   .font(.title3)
 //   .padding()
 //   .frame(width: 200)
 //   .background(Color("PrimaryColor"))
 //   .cornerRadius(5)
 //   .padding(.horizontal)
 //   .foregroundColor(Color.white)
    
    
    // main method to handeling the project id and project name
    func handleScan(result : Result<ScanResult,ScanError>){
        isShowingScanner = false
        
        
        switch result {
        case .success(let result):
            do {
                let qrResultData = result.string.data(using: .utf8)!
                let qrResult = try JSONDecoder().decode(QRResult.self, from: qrResultData)
                print(qrResult)
                print("Project ID: \(qrResult.userId)")
                
                self.userId = qrResult.userId
                self.projectName = qrResult.projectName
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
            
        case .failure(let error):
            print("scanning failed : \(error.localizedDescription) ")
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ScanView(path: .constant(NavigationPath()))
        }
    }
}
struct QRResult: Codable {
    let userId: Int
    let projectName: String
}

