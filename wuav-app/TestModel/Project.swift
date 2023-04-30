//
//  Project.swift
//  wuav-app
//
//  Created by Simko on 30/04/2023.
//

import Foundation

struct Project: Hashable,Identifiable {
   
    
    let id: Int
    let name: String
    let description: String
    let customer: Customer
    let type: CustomerType
    let createdAt: Date
    let mainImageURL: String
    let attachedImagesUrl: [String]
    let status: Status
    
    
    init(id: Int, name: String, description: String, customer: Customer, type: CustomerType, createdAt: Date, mainImageURL: String, attachedImagesUrl: [String], status: Status) {
        self.id = id
        self.name = name
        self.description = description
        self.customer = customer
        self.type = type
        self.createdAt = createdAt
        self.mainImageURL = mainImageURL
        self.attachedImagesUrl = attachedImagesUrl
        self.status = status
    }
    
    static func mockData() -> [Project] {
        [Project(id: 0, name: "Example Project", description: "Example Description", customer: Customer(id: 1, name: "John Doe", email: "john@example.com", phone: "1234567890", type: CustomerType(id: 1, name: "Individual")), type: CustomerType(id: 1, name: "Individual"), createdAt: Date(), mainImageURL: "https://example.com/image1.jpg", attachedImagesUrl: ["https://example.com/image1a.jpg"], status: .active)]
    }
    
}

