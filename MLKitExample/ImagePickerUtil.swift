import SwiftUI
import UIKit
import PhotosUI

struct ImagePickerView:UIViewControllerRepresentable{
//    typealias UIViewControllerType = PHPickerViewController
    
    // Binding object which connects to UI
    @Binding var image:UIImage?
    
    class Coordinator:NSObject,PHPickerViewControllerDelegate{
        var parent:ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else {return}
            
            if provider.canLoadObject(ofClass: UIImage.self){
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
            
        }
        
    }
    //ViewController
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        // pass coordinator to delegate instead of self
        picker.delegate = context.coordinator
        return picker
    }
    //UIViewControllerRepresentable method
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    //UIViewControllerRepresentable method
    func makeCoordinator() -> Coordinator {
        // sest imagePicker as a parent
        Coordinator(parent: self)
    }
    
}
