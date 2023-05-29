//  ARView.swift
//  wuav-app
//
//  Created by simko on 08/05/2023.

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import Combine
import UIKit
import RoomPlan
 

struct ArViewPage: View {
    @State var selectedDevices: Set<String> = []
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


struct DeviceMenu: View {
    @Binding var isExpanded: Bool
    @Binding var selectedDevices: Set<String>
    
    var devices = ["Speaker ", "Projector"]
    
    var body: some View {
        VStack(alignment: .leading) {
            if isExpanded {
                ForEach(devices, id: \.self) { device in
                    Button(action: {
                        if selectedDevices.contains(device) {
                            selectedDevices.remove(device)
                        } else {
                            selectedDevices.insert(device)
                           
                        }
                    }) {
                        Text(device)
                            .frame(minWidth: 100, alignment: .center)
                            .padding()
                            .background(selectedDevices.contains(device) ? Color.blue.opacity(0.8) : Color.white.opacity(0.8))
                            .foregroundColor(selectedDevices.contains(device) ? .white : .black)
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

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
    }
}


struct ARViewContainer: UIViewRepresentable {
    @Binding var selectedDevices: Set<String>

    func makeUIView(context: Context) -> ARView {
        let arView = FocusARView(frame: .zero)
        arView.addCoaching()
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        print("Updating ARView")
        
    
    //    for anchor in uiView.scene.anchors {
    //           uiView.scene.removeAnchor(anchor)
    //    }


    for device in selectedDevices {
           let anchor: HasAnchoring
           switch device {
           case "Speaker":
               anchor = try! DemoExperience.loadSpeaker()
           case "Projector":
               anchor = try! DemoExperience.loadSpeaker()
           default:
               anchor = try! DemoExperience.loadSpeaker()
           }
   
           if let modelEntity = anchor as? ModelEntity {
               modelEntity.generateCollisionShapes(recursive: true)
           }
   
           if let entity = anchor as? HasCollision {
               uiView.installGestures([.rotation,.translation,.scale],for: entity)
           }
   
           uiView.scene.anchors.append(anchor)
       }
    }
}




class CustomBox: Entity, HasModel, HasAnchoring, HasCollision {
    
    required init(color: UIColor) {
        super.init()
        self.components[ModelComponent.self] = ModelComponent(
            mesh: .generateBox(size: 0.1),
            materials: [SimpleMaterial(
                color: color,
                isMetallic: false)
            ]
        )
    }
    
    convenience init(color: UIColor, position: SIMD3<Float>) {
        self.init(color: color)
        self.position = position
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}





class FocusARView: ARView {
    enum FocusStyleChoices {
        case classic
        case material
        case color
    }

    /// Style to be displayed in the example
    let focusStyle: FocusStyleChoices = .classic
    var focusEntity: FocusEntity?
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        self.setupConfig()

        switch self.focusStyle {
        case .color:
            self.focusEntity = FocusEntity(on: self, focus: .plane)
        case .material:
            do {
                let onColor: MaterialColorParameter = try .texture(.load(named: "Add"))
                let offColor: MaterialColorParameter = try .texture(.load(named: "Open"))
                self.focusEntity = FocusEntity(
                    on: self,
                    style: .colored(
                        onColor: onColor, offColor: offColor,
                        nonTrackingColor: offColor
                    )
                )
            } catch {
                self.focusEntity = FocusEntity(on: self, focus: .classic)
                print("Unable to load plane textures")
                print(error.localizedDescription)
            }
        default:
            self.focusEntity = FocusEntity(on: self, focus: .classic)
        }
    }

    func setupConfig() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        session.run(config)
    }

    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




    


//struct DeviceMenu: View {
//    @Binding var isExpanded: Bool
//    @Binding var selectedDevices: Set<ARViewModel>
//
//    var devices: [ARViewModel] = {
//          // Creating some sample models
//          let models = [
//            ARViewModel(deviceName: "speaker", loadFunction: { try! //DemoExperience.loadSpeaker() as! any Entity & HasAnchoring & HasCollision }),
//
//            ARViewModel(deviceName: "stand", loadFunction: { try! //DemoExperience.loadStand() })
//          ]
//
//          return models
//      }()
//
//
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            if isExpanded {
//                ForEach(devices, id: \.self) { device in
//                    Button(action: {
//                        if selectedDevices.contains(where: { $0.modelName == //device.modelName }) {
//                            selectedDevices.remove(device)
//                        } else {
//                            selectedDevices.insert(device)
//                        }
//
//                    }) {
//                        Image(uiImage: device.uiImage)
//                            .resizable()
//                            .frame(width: 50,height: 50)
//                            .aspectRatio(1/1,contentMode: .fit)
//
//                        Text(device.modelName)
//                            .frame(minWidth: 100, alignment: .center)
//                            .padding()
//                            .background(selectedDevices.contains(where: { //$0.modelName == device.modelName }) ? //Color.blue.opacity(0.8) : //Color.white.opacity(0.8))
//                            .foregroundColor(selectedDevices.contains(where: //{ $0.modelName == device.modelName }) ? //.white : .black)
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                    }
//                }
//            }
//
//            Button(action: {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }) {
//                Image(systemName: "plus.circle.fill")
//                    .resizable()
//                    .frame(width: 60, height: 60)
//                    .rotationEffect(.degrees(isExpanded ? 45 : 0))
//                    .background(Color.white)
//                    .cornerRadius(30)
//                    .shadow(radius: 5)
//            }
//        }
//    }
//}




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
        
