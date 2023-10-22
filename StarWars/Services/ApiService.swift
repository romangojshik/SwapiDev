//
//  Service.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import Alamofire

enum SearchURL {
    case person
    case planet
    case starsShip
}

struct Constants {
    struct APIDetails {
        static let APIPath = "https://swapi.dev/api/"
        static let peoplePath = "people/"
        static let planetsPath = "planets"
        static let starsShipsPath = "starsShips"
    }
}

class ApiService {
    func serviceCall<T: Codable>(
        _ objectType: T.Type,
        paramSearch: SearchURL,
        name: String,
        completion: @escaping (GeneralResponse<T>?, Error?) -> Void
    ) {
        var fullPathURL: String = ""

        switch paramSearch {
        case .person:
            fullPathURL = Constants.APIDetails.APIPath + Constants.APIDetails.peoplePath
        case .planet:
            fullPathURL = Constants.APIDetails.APIPath + Constants.APIDetails.planetsPath
        case .starsShip:
            fullPathURL = Constants.APIDetails.APIPath + Constants.APIDetails.starsShipsPath
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

