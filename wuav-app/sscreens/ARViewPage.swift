//
//  ARView.swift
//  wuav-app
//
//  Created by simko on 08/05/2023.
//


import SwiftUI
import RealityKit
import ARKit

struct ArViewPage: View {
    @State var selectedDevices: Set<Model> = []
      @State var isExpanded = false
      
      var body: some View {
          ZStack {
              ARViewContainer(selectedDevices: $selectedDevices).edgesIgnoringSafeArea(.all)
              VStack {
                  Spacer()
                  DeviceMenu(isExpanded: $isExpanded, selectedDevices: $selectedDevices)
                      .padding()
              }
          }
      }
}



struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedDevices: Set<Model>
    
    func makeUIView(context: Context) -> ARView {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic
        
        if(ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh)){
            config.sceneReconstruction = .mesh
        }
        
     
        let arView = ARView(frame: .zero)
            
        // here was commented down
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Remove all existing anchors
        for anchor in uiView.scene.anchors {
            uiView.scene.removeAnchor(anchor)
        }
        
        // Add an anchor for each selected device
        for model in selectedDevices {
            guard let modelEntity = model.modelEntity else {
                fatalError("Model entity not loaded for: \(model.modelName)")
            }
            
            
            let anchor = AnchorEntity()
            anchor.addChild(modelEntity)
        

            anchor.generateCollisionShapes(recursive: true)

            // Add the anchor to the scene
            uiView.scene.anchors.append(anchor)
        }
    }
}




struct DeviceMenu: View {
    @Binding var isExpanded: Bool
    @Binding var selectedDevices: Set<Model>
   
  
     var devices : [Model] = {
        let fileManager = FileManager.default
        
        guard let path = Bundle.main.resourcePath,
                let files = try?
                fileManager.contentsOfDirectory(atPath : path)
       
        
        else {
            return []
        }
        
        var availableModels: [Model] = []
     
        
        for fileName in files where
        fileName.hasSuffix("usdz"){
            let modelName = fileName.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)
            availableModels.append(model)
            print(model)
        }
         
        return availableModels
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            if isExpanded {
                ForEach(devices, id: \.self) { device in
                    Button(action: {
                        if selectedDevices.contains(where: { $0.modelName == device.modelName }) {
                            selectedDevices.remove(device)
                        } else {
                            selectedDevices.insert(device)
                        }
                
                    }) {
                        Image(uiImage: device.uiImage)
                            .resizable()
                            .frame(width: 50,height: 50)
                            .aspectRatio(1/1,contentMode: .fit)
                                            
                        Text(device.modelName)
                            .frame(minWidth: 100, alignment: .center)
                            .padding()
                            .background(selectedDevices.contains(where: { $0.modelName == device.modelName }) ? Color.blue.opacity(0.8) : Color.white.opacity(0.8))
                            .foregroundColor(selectedDevices.contains(where: { $0.modelName == device.modelName }) ? .white : .black)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
            }
            
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(isExpanded ? 45 : 0))
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 5)
            }
        }
    }
}




#if DEBUG
struct ArViewPage_Previews : PreviewProvider {
    static var previews: some View {
        ArViewPage()
    }
}
#endif


//
//       for device in selectedDevices {
//           let anchor: Entity & HasAnchoring
//           switch device {
//           case "speaker":
//               anchor = try! DemoExperience.loadSpeaker()
//           case "stand":
//               anchor = try! DemoExperience.loadStand()
//           case "projector":
//               anchor = try! DemoExperience.loadStand()
//           default:
//               fatalError("Unknown device: \(device)")
//           }
//           // Generate collision shapes for the model
//           anchor.generateCollisionShapes(recursive: true)
//           // Install gestures for the model
//           arView.installGestures([.translation, .rotation, .scale], for: anchor as! Entity & HasCollision)
//
//           arView.scene.anchors.append(anchor)
 //       }
        
