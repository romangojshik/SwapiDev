//
//  HomeViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    // MARK: - Public Properties
    
    // MARK: - Subview Properties
    
    private lazy var contentView = ContentView().then {
        $0.delegate = self
    }
    
    // MARK: - Private Properties
    
    private let apiService = ApiService()
    private var contentViewModel = ContentViewModel()
    
    override func viewDidLoad() {
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
}

// MARK: - ContentViewProtocol

extension HomeViewController: ContentViewProtocol {
    func getInfoButtonDidTap(inputText: String, parameterForSearch: SearchURL) {
        switch parameterForSearch {
        case .person:
            apiService.serviceCall(
                PersonModel.self,
                paramSearch: parameterForSearch,
                name: inputText,
                completion: { (response, error) in
                    guard let result = response?.results.first else { return }
                    let personViewModel = ContentViewModel(
                        type: .person,
                        name: result.name,
                        gender: result.gender
                    )
                    self.contentView.configure(with: personViewModel)
                    self.contentViewModel = .init(name: result.name, gender: result.gender)
                }
            )
        case .planet:
            apiService.serviceCall(
                PlanetModel.self,
                paramSearch: parameterForSearch,
                name: inputText,
                completion: { (response, error) in
                    guard let result = response?.results.first else { return }
                    let peopleViewModel = ContentViewModel(
                        type: .planet,
                        name: result.name,
                        diameter: result.diameter
                    )
                    self.contentView.configure(with: peopleViewModel)
                }
            )
        case .starship:
            apiService.serviceCall(
                StarshipModel.self,
                paramSearch: parameterForSearch,
                name: inputText,
                completion: { (response, error) in
                    guard let result = response?.results.first else { return }
                    let peopleViewModel = ContentViewModel(
                        type: .starsShip,
                        name: result.name,
                        model: result.model,
                        manufacturer: result.manufacturer,
                        passengers: result.passengers
                    )
                    self.contentView.configure(with: peopleViewModel)
                }
            )
        }
    }
    
    func fovouriteButtonTapped(isFovourite: Bool) {
        let people = CoreDataManager.shared.fetchPeople()
        guard people.first(where: { $0.name == contentViewModel.name}) == nil else { return }
        
        guard
            let name = contentViewModel.name,
            let gender = contentViewModel.gender
        else { return }
        
        let id = UInt16.arc4random()
        CoreDataManager.shared.createPerson(
            id: Int32(id),
            name: name,
            gender: gender
        )
        CoreDataManager.shared.isUpdate = true
    }
}
