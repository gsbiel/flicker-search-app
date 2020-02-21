//
//  FlickrAPI.swift
//  flicker-search
//
//  Created by user164622 on 2/19/20.
//  Copyright © 2020 user164622. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FlickrAPI {
    
    static private let parameters: [String: String] = [
        "method": "flickr.photos.search",
        "api_key": APIData.API_key,
        "text": "Phantom",
        "per_page": "20",
        "page": "1",
        "format": "json",
        "nojsoncallback" : "1"
    ]
    
    static private let baseURL: String =  "https://www.flickr.com/services/rest"
    
    static func getPhotoURL(completion: @escaping(([String : [String]]) -> ())){
        print("Requisitando dados das imagens...")
        Alamofire.request(self.baseURL, parameters: self.parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let photoDataJSON: JSON = JSON(response.result.value!)
                var photosURL: [String] = [String]()
                for photo in photoDataJSON["photos"]["photo"] {
                    let farm_id = photo.1["farm"]
                    let server_id = photo.1["server"]
                    let id = photo.1["id"]
                    let secret = photo.1["secret"]
                    let size = "s"
                    photosURL.append("https://farm\(farm_id).staticflickr.com/\(server_id)/\(id)_\(secret)_\(size).jpg")
                }
                completion(["success" : photosURL])
            }
            else{
                print("")
                completion(["error" : ["Aconteceu um erro na requisicao feita em getPhotoData"]])
            }
        }
    }
}

/*
     A URL abaixo retorna um JSON com a lista de dados sobre as fotos encontradas. Desse JSON, voce vai remover informacoes para montar a URL da foto em si. Sao elas: farm, server, id, secret e size s, q, t, m, n
    "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIData.API_key)&text=Phantom&per_page=20&page=1&format=json&nojsoncallback=1"
    
     A URL abaixo leva diretamente a imagem.
    private let photoUrl = "https://farm\(farm_id).staticflickr.com/\(server_id)/\(id)_\(secret)_\(size).jpg"
 */
