//
//  UploadView2.swift
//  wuav-app
//
//  Created by simko on 03/05/2023.
//

import SwiftUI

struct UploadView2: View {
    let userId: Int
    let projectName: String
    @State private var items: [ImageItem] = []
    @State private var isPickerShown: Bool = false
    @State private var image = UIImage()
    @State private var isPreviewShown: Bool = false
    @State private var previewImage: UIImage = UIImage()
    @State private var showCompletedView: Bool = false
    @Binding var path: NavigationPath
    @State private var portAcademy: String =  ""
    

    
    @State private var portDev: String =  ""
    
    func uploadImageToEndpoint(image: UIImage) {
     
        // do all the api handeling here
        // userId is collected from qr code
        let boundary = UUID().uuidString
        let requestURL = URL(string: "\(portDev)/api/users/\(userId)/images")!
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        
        // Add the image data to the request body
        let imageData = image.jpegData(compressionQuality: 1.0)!
        httpBody.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: String.Encoding.utf8)!)
        httpBody.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
        httpBody.append(imageData)
        httpBody.append("\r\n".data(using: String.Encoding.utf8)!)
        
        // Add any other required parameters to the request body
        httpBody.append("--\(boundary)--".data(using: String.Encoding.utf8)!)
        request.httpBody = httpBody as Data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Image uploaded successfully!")
                } else {
                    print("Error uploading image: HTTP status code \(response.statusCode)")
                }
            }
        }
        task.resume()
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment:.center) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Project name: ")
                            .bold()
                            .font(.system(size: 25))
                        Text("\(projectName)")
                            .font(.system(size: 25))
                    }
                    
                    HStack {
                        Text("Technician id: ")
                            .bold()
                            .font(.system(size: 25))
                        Text("\(userId)")
                            .font(.system(size: 25))
                    }
                }
                .padding(30)
                .frame(width: 400, height: 100, alignment: .topLeading)
            }
            
            
            if items.isEmpty {
                ZStack {
                    
                           VStack {
                               Image("no-data")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 3)

                               Text("No images uploaded!")
                                   .foregroundColor(.gray)
                                   .font(.system(size: 24))
                                   .fontWeight(.bold)
                                   .padding()
                           }
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                       }
            } else {
                
                List {
                    ForEach(items.indices, id: \.self) { index in
                        HStack {
                            Image(uiImage: items[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            
                            Text("image_upload_\(index)")
                            
                            
                            Spacer()
                            
                            Button(action: {
                                items.remove(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }
                        }
                    }
                    
                }
                .background(Color.clear)
                .listStyle(PlainListStyle())
            }
            
    
            
      //      Button(action: addItem) {
      //          Text("Add item")
      //
      //
      //      }
      //      .frame(width: 350,height: 60)
      //      .background(items.count >= 2 ? Color.gray : //Color("PrimaryColor"))
      //      .cornerRadius(5)
      //      .padding(.horizontal)
      //      .foregroundColor(Color.white)
      //      .padding(.horizontal)
      //      .padding(.bottom)
      //      .disabled(items.count >= 2)
            
            Button(action: addItem)
            {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 5)
            }.frame(width: 350,height: 100)
                .cornerRadius(5)
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.bottom)
                .disabled(items.count >= 2)
            
            
        
     //        Button(action: finishTask) {
     //            Text("Upload")
     //
     //
     //        }
     //        .frame(width: 350,height: 55)
     //        .background(items.count < 2 ? Color.gray : // Color("PrimaryColor"))
     //        .cornerRadius(5)
     //        .padding(.horizontal)
     //        .foregroundColor(Color.white)
     //        .padding(.horizontal)
     //        .padding(.bottom)
     //        .disabled(items.count < 2)
        
    

            
        }
        .sheet(isPresented: $isPickerShown){
            ImagePicker(selectedImage: self.$image, onImagePicked: {
                items.append(ImageItem(image: image, name: "Default Name"))
            }, sourceType: .camera)
        }
        .sheet(isPresented: $showCompletedView) {
            CompletedView(path:$path)
        }
        .fullScreenCover(isPresented: $isPreviewShown) {
          //  ImagePreview(image: previewImage)
        }
        
        
        
    }
    
    func finishTask(){
        initImageUpload()
        showCompletedView = true
    }
    
    func addItem() {
        isPickerShown = true
    }
    
    
    func initImageUpload(){
        print("Uploading to proxy")
        
        
        for item in items {
            uploadImageToEndpoint(image: item.image)
        }
    }
    
    
}

struct UploadView2_Previews: PreviewProvider {
    static var previews: some View {
        UploadView2(userId : 3,projectName : "Initial_project",path: .constant(NavigationPath()))
    }
}
