//
//  ContentView.swift
//  MLKitExample
//
//  Created by Kentaro Mihara on 2023/11/28.
//

import SwiftUI
import MLKit
import MLImage

struct ContentView: View {
    var body: some View {
        //SingleImagePickerScreen()
        CameraUIViewControllerRepresentable()
    }
}

#Preview {
    ContentView()
}
