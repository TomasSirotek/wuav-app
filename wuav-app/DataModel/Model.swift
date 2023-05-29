//
//  Model.swift
//  wuav-app
//
//  Created by simko on 12/05/2023.
//

import Foundation
import UIKit
import RealityKit
import Combine


class Model: Hashable {
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.modelName == rhs.modelName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(modelName)
    }
    
    var modelName: String
    var uiImage: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable : AnyCancellable? = nil
    
    init(modelName: String){
        self.modelName = modelName
        if let image = UIImage(named: modelName) {
            self.uiImage = image
        } else {
            print("No image found for model: \(modelName)")
            self.uiImage = UIImage() // Use a placeholder image or a default image
        }
        let fileName = modelName + ".usdz"
        
        
        self.cancellable = ModelEntity.loadModelAsync(named: fileName).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Failed to load model: \(error)")
            }
        }, receiveValue: { modelEntity in
            self.modelEntity = modelEntity
        })
        
    }
}
