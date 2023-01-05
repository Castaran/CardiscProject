//
//  ImagePicker.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 30/12/2022.
//

import SwiftUI
import PhotosUI

@MainActor
class ImagePicker: ObservableObject {
    
    private let apiService = ApiService()
    
    @Published var image: Image?
    @Published var images: [Image] = []
    
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    // Maak de URL voor de request
                    let url = URL(string: Constants.API_BASE_URL + "user/avatar")!
                    
                    // Maak de request
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    
                    // Zet de content type op image/jpeg
                    request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
                    if let token = UserDefaults.standard.string(forKey: "X-AUTHTOKEN") {
                        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
                    }
                    
                    self.image = Image(uiImage: uiImage)
                    let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
                    
                    
                    // Zet het request body op de afbeeldingsdata
                    request.httpBody = data
                    
                    // Maak de taak om de request te versturen
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            return
                        }
                        do {
                            print(data.count)
                            
                        }
                        catch{
                            print("error: \(error.localizedDescription)")
                        }
                    }
                    
                    // Verstuur de request
                    task.resume()
                    
                    
                }
            }
        } catch {
            print(error.localizedDescription)
            image = nil
        }
    }
}
