//
//  CustomerType.swift
//  wuav-app
//
//  Created by Legind on 30/04/2023.
//

import Foundation


struct CustomerType: Hashable,Identifiable {
   
    
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
