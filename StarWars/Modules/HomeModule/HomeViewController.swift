//
//  HomeViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import UIKit

fileprivate struct HomeVCConstants {
    static let addNewTask = "You add in favourites "
}

public final class HomeViewController: UIViewController {
    // MARK: - Public Properties
    
    // MARK: - Subview Properties
    
    private lazy var contentView = ContentView().then { $0.delegate = self }
    
    // MARK: - Private Properties
    
    private let apiService = ApiService()
    private var contentViewModel = ContentViewModel()
    private var objectModel = ObjectModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func showAlertScreen(nameObject: String) {
        let alertController = UIAlertController(
            title: "",
            message: "\(HomeVCConstants.addNewTask)\(nameObject)",
            preferredStyle: .alert
        )
        
        alertController.view.backgroundColor = .darkGray
        alertController.view.alpha = 0.6
        alertController.view.layer.cornerRadius = 15
        
        self.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
          self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - ContentViewProtocol
extension HomeViewController: ContentViewProtocol {
    func getInfoButtonDidTap(inputText: String, parameterForSearch: SearchType) {
        switch parameterForSearch {
        case .person:
            apiService.serviceCall(
                PersonModel.self,
                paramSearch: parameterForSearch,
                name: inputText,
                completion: { (response, error) in
                    guard let result = response?.results.first else { return }
                    let personModel = ObjectModel(
                        type: .person,
                        name: result.name,
                        gender: result.gender
                    )
                    self.contentView.configure(with: personModel)
                    self.objectModel = .init(type: .person, name: result.name, gender: result.gender)
                }
            )
        case .planet:
            apiService.serviceCall(
                PlanetModel.self,
                paramSearch: parameterForSearch,
                name: inputText,
                completion: { (response, error) in
                    guard let result = response?.results.first else { return }
                    let planetModel = ObjectModel(
                        type: .planet,
                        name: result.name,
                        diameter: result.diameter,
                        population: result.population
                    )
                    self.contentView.configure(with: planetModel)
                    self.objectModel = .init(
                        type: .planet,
                        name: result.name,
                        diameter: result.diameter,
                        population: result.population
                    )
                }
            )
        case .starship:
            apiService.serviceCall(
                StarshipModel.self,
                paramSearch: parameterForSearch,
                name: inputText,
                completion: { (response, error) in
                    guard let result = response?.results.first else { return }
                    let starshipModel = ObjectModel(
                        type: .starship,
                        name: result.name,
                        model: result.model,
                        manufacturer: result.manufacturer,
                        passengers: result.passengers
                    )
                    self.contentView.configure(with: starshipModel)
                    self.objectModel = .init(
                        type: .starship,
                        name: result.name,
                        model: result.model,
                        manufacturer: result.manufacturer,
                        passengers: result.passengers
                    )
                }
            )
        case .none:
            break
        }
    }
    
    func fovouriteButtonTapped(isFovourite: Bool, type: SearchType) {
        var nameObject = ""
        switch type {
        case .person:
            contentViewModel.createPerson(
                name: objectModel.name,
                gender: objectModel.gender
            )
            nameObject = objectModel.name ?? ""
        case .planet:
            contentViewModel.createPlanet(
                name: objectModel.name,
                diameter: objectModel.diameter,
                population: objectModel.population
            )
            nameObject = objectModel.name ?? ""
        case .starship:
            contentViewModel.createStarship(
                name: objectModel.name,
                model: objectModel.model,
                manufacturer: objectModel.manufacturer,
                passengers: objectModel.passengers
            )
            nameObject = objectModel.name ?? ""
        default:
            break
        }
        showAlertScreen(nameObject: nameObject)
    }
}
