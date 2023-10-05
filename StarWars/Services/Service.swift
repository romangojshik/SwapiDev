//
//  Service.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import Foundation
import Alamofire

enum SearchURL {
    case people
    case planet
    case starsShip
}

//enum StringURL: String, CustomStringConvertible {
//    case luke = "Luke Skywalker"
//    case yavin = "Yavin IV"
//    case death = "Death Star"
//
//    var description: String {
//        switch self {
//        case .luke:
//            return "people/1/"
//        case .yavin:
//            return "planets/3/"
//        case .death:
//            return "starships/9/"
//        }
//    }
//
//
//    static func initialize(stringValue: String)-> StringURL? {
//        switch stringValue {
//        case StringURL.luke.description:
//            return StringURL.luke
//        case  StringURL.yavin.description:
//            return StringURL.yavin
//        case StringURL.death.description:
//            return StringURL.death
//        default:
//            return nil
//        }
//    }
//}

struct Constants {
    struct APIDetails {
        static let APIPath = "https://swapi.dev/api/"
        static let peoplePath = "people/"
        static let planetsPath = "planets"
        static let starsShipsPath = "starsShips"
    }
}

class Service {
    func serviceCall<T: Codable>(
        _ objectType: T.Type,
        paramSearch: SearchURL,
        name: String,
        completion: @escaping (GeneralResponse<T>?, Error?) -> Void
    ) {
        var fullPathURL: String = ""

        switch paramSearch {
        case .people:
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

