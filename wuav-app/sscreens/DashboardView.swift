//
//  DashboardView.swift
//  wuav-app
//
//  Created by Simko on 29/04/2023.
//

import SwiftUI

struct DashboardView: View {
    
    // Mock data
    
    
    
    
    let individual: CustomerType
    let corporate: CustomerType
    
    // Sample customers
    let customer1: Customer
    let customer2: Customer
    
    // Sample projects
    var projects: [Project]
    
    init() {
        individual = CustomerType(id: 1, name: "Individual")
        corporate = CustomerType(id: 2, name: "Corporate")
        
        customer1 = Customer(id: 1, name: "John Doe", email: "john@example.com", phone: "1234567890", type: individual)
        customer2 = Customer(id: 2, name: "Jane Smith", email: "jane@example.com", phone: "0987654321", type: corporate)
        
        projects = [
            .init(id: 0, name: "Nørregade 33", description: "First installation", customer: customer1, type: individual, createdAt: Date(), mainImageURL: "https://example.com/image1.jpg", attachedImagesUrl: ["https://example.com/image1a.jpg"], status: .active),
            .init(id: 1, name: "Vesterbro", description: "Second installation", customer: customer1, type: individual, createdAt: Date(), mainImageURL: "https://example.com/image2.jpg", attachedImagesUrl: ["https://example.com/image2a.jpg"], status: .completed),
            .init(id: 2, name: "Østerbro", description: "Third installation", customer: customer2, type: corporate, createdAt: Date(), mainImageURL: "https://example.com/image3.jpg", attachedImagesUrl: ["https://example.com/image3a.jpg"], status: .completed)
        ]
    }
    
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Header() // header
                
                SearchBar() // search
                    .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("In progress").font(.title2).bold()
                    
                    ActiveItems(projects : projects, status: .active)
                }
                .padding(.top,10)
              
               
                
                
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Completed").font(.title2).bold()
                    
                    ActiveItems(projects : projects, status: .completed)
                }
                .padding(.top,-30)
               
                
                
                Spacer()
            }
            .navigationBarHidden(false) // for now
            .padding(.leading, 40) // Increase the leading (left) padding
            .padding(.trailing, 40) // Increase the trailing (right) padding
        }
    }
    
    struct DashboardView_Previews: PreviewProvider {
        static var previews: some View {
            DashboardView()
        }
    }
    
    struct SearchBar: View {
        @State private var searchText = ""
        
        var body: some View {
            HStack {
                Image("search")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                    .scaledToFit()
                
                TextField("Search", text: $searchText)
                    .padding(.leading, 5)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.all, 10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

struct Header: View {
    @State private var user: String = "Michael" // for now to mock
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Hello, " + user).font(.system(size: 40))
            }
            Spacer()
        }
        .padding(.top, 30)
    }
}


// OBJECTS ... move later to separate file/folder

struct Project: Hashable {
    let id: Int
    let name: String
    let description: String
    let customer: Customer
    let type: CustomerType
    let createdAt: Date
    let mainImageURL: String
    let attachedImagesUrl: [String]
    let status: Status
}

struct Customer: Hashable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let type: CustomerType
    // let address: Address // Need to be added later
}

enum Status: String, Hashable {
    case active = "ACTIVE"
    case completed = "COMPLETED"
    case deleted = "DELETED"
}

struct CustomerType: Hashable {
    let id: Int
    let name: String
}






struct ActiveItems: View {
    var projects: [Project]
    var status: Status
    
    var body: some View {
        List {
            ForEach(projects.filter { $0.status == status }, id: \.id) { project in
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(project.name)
                                .font(.title3)
                                .bold()
                            Text(project.type.name)
                                .font(.body)
                        }
                        Spacer()
                        Button(action: {
                            // Details button action
                        }) {
                            Text(project.status == .active ? "Active" : "Completed")
                                .font(.callout)
                                .foregroundColor(project.status == .active ? .blue : .green)
                        }
                    }
                    
                    Divider()

                    HStack(spacing: 10) {
                        Text(project.createdAt, style: .date)
                            .font(.callout)
                            .foregroundColor(.gray)
                        Spacer()

                        NavigationLink(destination: UploadView()) {
                            Text("Upload photos").font(.system(size: 15))
                        }
                        .padding(20)
                        .frame(width: 170, height: 40)
                        .foregroundColor(.white)
                        .background(project.status == .completed ? Color("PrimaryColor").opacity(0.5) : Color("PrimaryColor"))
                        .cornerRadius(5)
                        .disabled(project.status == .completed)
                    }
                    .padding(.leading, 0)
                    .padding(.trailing, 1)
                    .padding(.bottom, 10)

                }
                .padding()
                
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
        }
       
        .listStyle(PlainListStyle())

    }
}
