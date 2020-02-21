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
    
    static func getPhotoData() {
        print("Requisitando dados...")
        AF.request(self.baseURL, parameters: self.parameters).validate().responseJSON { (response) in
            print(response.result)
        }
    }
}

/*
     A URL abaixo retorna um JSON com a lista de dados sobre as fotos encontradas. Desse JSON, voce vai remover informacoes para montar a URL da foto em si. Sao elas: farm, server, id, secret e size s, q, t, m, n
    "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIData.API_key)&text=Phantom&per_page=20&page=1&format=json&nojsoncallback=1"
    
     A URL abaixo leva diretamente a imagem.
    private let photoUrl = "https://farm\(farm_id).staticflickr.com/\(server_id)/\(id)_\(secret)_\(size).jpg"
 */
