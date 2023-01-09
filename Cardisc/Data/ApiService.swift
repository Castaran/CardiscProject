//
//  API.swift
//  Cardisc
//
//  Created by Tim van Kesteren on 20/11/2022.
//

import Foundation
import MultipartForm

class ApiService {
    
    // GET request
    func getData<T: Decodable>
    (
        body: Dictionary<String, AnyHashable>?,
        url: String,
        model: T.Type,
        completion:@escaping(T) -> (),
        failure:@escaping(Error) -> ()
    )
    {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    //POST request
    func httpRequest<T: Decodable>
    (
        body: Dictionary<String, AnyHashable>?,
        url: String,
        model: T.Type?,
        httpMethod: String,
        completion:@escaping(T) -> (),
        failure:@escaping(Error) -> ()
    )
    {
        guard let url = URL(string: Constants.API_BASE_URL + url) else {
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        //if token is given with at the manager
        if let token = UserDefaults.standard.string(forKey: "X-AUTHTOKEN") {
            request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        //if body is given with at the manager
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let responseCode = httpResponse.statusCode
                if responseCode == 204 {
                    UserDefaults.standard.removeObject(forKey: "X-AUTHTOKEN")
                }
                
            }
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response)
            }
            catch{
                print("error: \(error.localizedDescription)")
                failure(error)
            }
        }
        
        task.resume()
    }
    
    //POST request
    func httpRequestWithoutReturn
    (
        body: Dictionary<String, AnyHashable>?,
        url: String,
        httpMethod: String
    )
    {
        guard let url = URL(string: Constants.API_BASE_URL + url) else {
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        //if token is given with at the manager
        if let token = UserDefaults.standard.string(forKey: "X-AUTHTOKEN") {
            request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        //if body is given with at the manager
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        }
        
        let task = URLSession.shared.dataTask(with: request)
        
        task.resume()
    }
    
    func httpUploadRequest<T: Decodable>
    (
        model: T.Type,
        formData: MultipartForm
    ) {
        let url = URL(string: Constants.API_BASE_URL + "user/avatar")!
        var request = URLRequest(url: url)
        
        if let token = UserDefaults.standard.string(forKey: "X-AUTHTOKEN") {
            request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "POST"
        request.setValue(formData.contentType, forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: formData.bodyData)
        task.resume()
    }
    
}
