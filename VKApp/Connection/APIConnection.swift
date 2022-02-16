//
//  APIConnection.swift
//  TairianVK
//
//  Created by hayk on 30/11/2020.
//  Copyright © 2020 Tairian. All rights reserved.
//

import Foundation
import Alamofire

let apiConnection = APIConnection.instance

class APIConnection {
    
    static let instance = APIConnection()
    private init() { }
    
    let baseURL = "https://api.vk.com/method/"
    let session = Session.instance
    
    private func getRequest(_ path: String, withParams: Parameters, completion: @escaping (Data) -> Void) {
        
        guard let token = session.token else { return }
        
        var params: Parameters = [
            "access_token": token,
            "v": "5.126",
        ]
        
        params += withParams
        
        let url = baseURL + path
        
        request(url, parameters: params).responseData { (response) in
            guard let data = response.data else { return }
            completion(data)
        }
    }
    
    func getImage(_ url: String, completion: @escaping (UIImage) -> Void) {
        
        request(url).response { (response) in
            guard
                let data = response.data,
                let image = UIImage(data: data, scale:1)
                else { return }
            
            completion(image)
        }
    }
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        
        let params = ["fields": "online, photo_100",
                      "count": "50"]
        
        getRequest("friends.get", withParams:params) { (data) in
            
            do {
                let response = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }
    
    func getProfilePhotos(of owner: Int, completion: @escaping ([Photo]) -> Void) {
        
        let params = ["owner_id": owner.toString,
                      "album_id": "profile",
                      "rev": "1",
                      "count": "10"]
            
        getRequest("photos.get", withParams:params) { (data) in

            do {
                let response = try JSONDecoder().decode(PhotoResponse.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        
        let params = ["extended": "1",
                      "count": "100"]
            
        getRequest("groups.get", withParams:params) { (data) in
            
            do {
                let response = try JSONDecoder().decode(GroupResponse.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }
    
    func searchGroups(for query: String, completion: @escaping ([Group]) -> Void) {
        
        let params = ["q": query,
                      "count": "100"]
            
        getRequest("groups.search", withParams:params) { (data) in
            
            do {
                let response = try JSONDecoder().decode(GroupResponse.self, from: data)
                completion(response.items)
            } catch {
                completion([])
            }
        }
    }
    
}
