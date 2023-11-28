import Foundation
import SwiftUI
import MLKit

struct SingleImagePickerScreen: View {
    @State private var image:Image?
    @State private var inputImage:UIImage?
    @State private var showingImagePicker = false
    
    @State var face_count = 0
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
            Button {
                showingImagePicker = true
            } label: {
                Text("Select Image")
            }
            .padding()
            Button {
                // detect
                if let inputImage = inputImage{
                    detect(image: inputImage)
                }else{
                    print("inputImage is nil")
                }
            } label: {
                Text("Detect")
            }
            .padding()
            Text("face count: \(face_count)")
                .padding()
         //Button triggers ImagePicker
        }.sheet(isPresented: $showingImagePicker) {
            ImagePickerView(image: $inputImage)
        }//if inputImage chagnes, loadImage to show it
        .onChange(of: inputImage) { newValue in
            loadImage()
        }
    }
    
    func detect(image: UIImage){
        let options = FaceDetectorOptions()
        options.landmarkMode = .all
        options.classificationMode = .all
        options.performanceMode = .accurate
        options.contourMode = .all
        
        // [START init_face]
        let faceDetector = FaceDetector.faceDetector(options: options)
        // [END init_face]

        // Initialize a `VisionImage` object with the given `UIImage`.
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation

        
        // [START detect faces]
        faceDetector.process(visionImage){faces, error in
            
            guard error == nil, let faces = faces, !faces.isEmpty else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? "tmp error"
                print(errorString)
                // [END_EXCLUDE]
                return
            }
            
            print("done")
            print(faces)
            face_count = faces.count
            
            
            
        }
        
    }
    
    
    // showing image
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
}
