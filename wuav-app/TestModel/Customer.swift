//
//  Customer.swift
//  wuav-app
//
//  Created by Simko on 30/04/2023.
//

import Foundation



struct Customer: Hashable,Identifiable {

    let id: Int
    let name: String
    let email: String
    let phone: String
    let type: CustomerType
    // let address: Address // Need to be added later
    
    
    init(id: Int, name: String, email: String, phone: String, type: CustomerType) {
           self.id = id
           self.name = name
           self.email = email
           self.phone = phone
           self.type = type
       }
       
}


