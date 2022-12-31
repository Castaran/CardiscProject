//
//  MultiImagePicker.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 30/12/2022.
//

import SwiftUI
import PhotosUI

struct MultiImagePickerView: View {
    @StateObject var imagePicker = ImagePicker()
    let columns = [GridItem(.adaptive(minimum: 100))]
    var body: some View {
            NavigationStack {
                VStack {
                    if !imagePicker.images.isEmpty {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(0..<imagePicker.images.count, id: \.self) { index in
                                    imagePicker.images[index]
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                    } else {
                        Text("Tap the menu bar button to select multiple photos.")
                    }
                }
                .padding()
                .navigationTitle("Multiple Picker")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        PhotosPicker(selection: $imagePicker.imageSelections,
                                     maxSelectionCount: 10,
                                     matching: .images,
                                     photoLibrary: .shared()) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .imageScale(.large)
                        }
                        
                    }
                }
            }
        }
}

struct MultiImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiImagePickerView()
    }
}

