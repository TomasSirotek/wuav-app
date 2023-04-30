//
//  UploadView.swift
//  wuav-app
//
//  Created by Legind on 30/04/2023.
//

import SwiftUI

struct UploadView: View {
    var item : Project
    @State private var items: [String] = []
    
    
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
                    ForEach(items, id: \.self) { item in
                        HStack {
                            Text(item)
                            Spacer()
                            Button(action: { deleteItem(item: item) }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .listRowBackground(Color.clear)
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
            
            Button(action: initImageUpload) {
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
        .padding()
        .navigationTitle(item.name)
    }
    
    
    func addItem() {
        let newItem = "Upload image \(items.count + 1)"
        items.append(newItem)
    }
    
    func deleteItem(item: String) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
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
