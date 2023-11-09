//
//  Service.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import Alamofire

struct APIConstants {
    struct APIDetails {
        static let APIPath = "https://swapi.dev/api/"
        static let peoplePath = "people/"
        static let planetPath = "planets/"
        static let starshipPath = "starships/"
    }
}

class ApiService {
    func serviceCall<T: Codable>(
        _ objectType: T.Type,
        paramSearch: SearchType,
        name: String,
        completion: @escaping (GeneralResponse<T>?, Error?) -> Void
    ) {
        var fullPathURL: String = ""

        switch paramSearch {
        case .person:
            fullPathURL = APIConstants.APIDetails.APIPath + APIConstants.APIDetails.peoplePath
        case .planet:
            fullPathURL = APIConstants.APIDetails.APIPath + APIConstants.APIDetails.planetPath
        case .starship:
            fullPathURL = APIConstants.APIDetails.APIPath + APIConstants.APIDetails.starshipPath
        case .none:
            break
        }
        
        let paramPath = ["search": name]
        AF.request(
            fullPathURL,
            method: .get,
            parameters: paramPath,
            encoding: URLEncoding.default
        )
        .responseDecodable(of: GeneralResponse<T>.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                let error = error
                print(error.localizedDescription)
            }
        }
    }
}

