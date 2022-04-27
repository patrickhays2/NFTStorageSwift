import Foundation
import SwiftUI

public class NFTStorageAPI {
    
    private var apiKey:String
    
    public init(_ key:String) {
        apiKey = key
    }
    
    private let basePath = "https://api.nft.storage/"
    
    public func uploadFile(fileName:String,fileExtension:String,completion:@escaping (String) -> ()) {
        if let filePath = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            let path = filePath.self
            let filePathData = try? Data(contentsOf: path)
            let url = URL(string:"\(basePath)upload")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = ["Authorization":"Bearer \(apiKey)","Content-Type":"application/json"]
            request.httpBody = filePathData
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let callData = try? JSONDecoder().decode(UploadResponse.self, from: data!) {
                    let values = callData.value
                    print(values.cid!)
                    print(values.created!)
                    DispatchQueue.main.async {
                        completion(values.cid!)
                    }
                }
            }
            task.resume()
        }
    }
    
    public func uploadStringData(_ stringData:String,completion:@escaping (Bool,String,String) -> ()) {
        let url = URL(string:"\(basePath)upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Authorization":"Bearer \(apiKey)","Content-Type":"application/json"]
        request.httpBody = stringData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let callData = try? JSONDecoder().decode(UploadResponse.self, from: data!) {
                if callData.ok == true {
                    let values = callData.value
                    completion(true,"Data uploaded successfully.",values.cid!)
                }
            } else if let errorData = try? JSONDecoder().decode(UploadFailureResponse.self, from: data!) {
                completion(false,"Encountered a problem:",errorData.error!.message)
            }
            else {
                completion(false,"Unable to process to API request.","")
            }
        }
        task.resume()
    }
    
    public func getStringData(_ cidURL:String,completion:@escaping (String) -> ()) {
        let url = URL(string:"\(cidURL)")!
    var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            let dataString = String(decoding: data!, as: UTF8.self)
            DispatchQueue.main.async {
                completion(dataString)
            }
        }
        task.resume()
    }
    
    public func deleteData(_ cid:String,completion:@escaping (Bool,String,String) -> ()) {
        let url = URL(string:"\(basePath)\(cid)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["Authorization":"Bearer \(apiKey)","accept":"application/json"]
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let callData = try? JSONDecoder().decode(DeleteResponse.self, from: data!) {
                if callData.ok == true {
                    completion(true,"File deleted successfully.","None")
                } else if callData.ok == false {
                    completion(false,"Encountered a problem:",callData.error!.message)
                }
            }
            else {
                completion(false,"Unable to process to API request.","")
            }
        }
        task.resume()
    }
}
