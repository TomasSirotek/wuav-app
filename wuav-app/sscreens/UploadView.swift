//
//  UploadView.swift
//  wuav-app
//
//  Created by Simko on 30/04/2023.
//

import SwiftUI

struct UploadView: View {
    var item : Project
    //@State private var items: [UIImage] = []
    @State private var items: [ImageItem] = []
    @State private var isPickerShown: Bool = false
    @State private var image = UIImage()
    @State private var isPreviewShown: Bool = false
    @State private var previewImage: UIImage = UIImage()
    @State private var showCompletedView: Bool = false
    
 
    // HAS TO BE FIXED
    
    //   Button(action: {
    //       previewImage = items[index]
    //       isPreviewShown = true
    //   }) {
    //       Image(systemName: "arrow.up.left.and.arrow.down.right")
    //           .font(.title2)
    //   }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Upload photos")
                    .bold()
                    .font(.system(size: 30))
                    .frame(alignment: .topLeading)
            }
            .padding(30)
            
            .frame(width: 300, height: 100, alignment: .topLeading)
            
            if items.isEmpty {
                Text("No images uploaded !")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.gray)
            } else {
                
                List {
                    ForEach(items.indices, id: \.self) { index in
                        HStack {
                            Image(uiImage: items[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            
                            TextField("Image name", text: $items[index].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
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
            
            Spacer()
            
            Button(action: addItem) {
                Text("Add item")
                
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(items.count >= 2 ? Color.gray : Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .disabled(items.count >= 2)
            
            Button(action: {
                initImageUpload()
                showCompletedView = true
            }) {
                Text("Finish")
                
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(items.count < 2 ? Color.gray : Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .disabled(items.count < 2)
        }
        .sheet(isPresented: $isPickerShown){
            ImagePicker(selectedImage: self.$image, onImagePicked: {
                items.append(ImageItem(image: image, name: "Default Name"))
            }, sourceType: .camera)
        }
        .sheet(isPresented: $showCompletedView) {
            CompletedView()
        }
        .fullScreenCover(isPresented: $isPreviewShown) {
            ImagePreview(image: previewImage)
        }
        .padding()
        
        .navigationTitle(item.name)
    }
    
    
    func addItem() {
        isPickerShown = true
    }
    
    
    func initImageUpload(){
        print("Uploading to proxy")
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(item: Project(id: 0, name: "Example Project", description: "Example Description", customer: Customer(id: 1, name: "John Doe", email: "john@example.com", phone: "1234567890", type: CustomerType(id: 1, name: "Individual")), type: CustomerType(id: 1, name: "Individual"), createdAt: Date(), mainImageURL: "https://example.com/image1.jpg", attachedImagesUrl: ["https://example.com/image1a.jpg"], status: .active))
    }
}

struct ImagePreview: View {
    var image: UIImage
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            Spacer()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Close")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.bottom)
        }
    }
}

extension Binding where Value == Bool {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { wrappedValue },
            set: { newValue in
                wrappedValue = newValue
                handler(newValue)
            }
        )
    }
    
}
