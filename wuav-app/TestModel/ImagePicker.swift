
import Foundation
import UIKit
import SwiftUI



struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    var onImagePicked: () -> Void
    var sourceType: UIImagePickerController.SourceType = .camera
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                    
                    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                        parent.selectedImage = image
                        parent.onImagePicked()
                    }
                    
                    parent.presentationMode.wrappedValue.dismiss()
                }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need to implement this method if not updating the UIImagePickerController
    }
}

