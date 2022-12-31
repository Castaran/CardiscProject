//
//  SingleImagePicker.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 30/12/2022.
//

import SwiftUI
import PhotosUI

struct SingleImagePickerView: View {
    @StateObject var imagePicker = ImagePicker()
    var body: some View {
        NavigationStack {
            VStack {
                if let image = imagePicker.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Tap the menu bar button to select a photo.")
                }
            }
            .padding()
            .navigationTitle("Single Picker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $imagePicker.imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct SingleImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        SingleImagePickerView()
    }
}
