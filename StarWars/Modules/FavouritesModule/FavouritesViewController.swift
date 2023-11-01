//
//  FavouritesViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import SnapKit
import CoreData


class FavouritesViewController: UIViewController {
    // MARK: - Subview Properties
    
    private lazy var contentView = ContentFavouritesView().then {
        $0.delegate = self
    }
    
    // MARK: - Private Properties
    
    private var contentViewModel = ContentViewModel()
    private let apiService = ApiService()
    private var isReloadContent = false
    private var people: [Person] = []
    private var planets: [Planet] = []
    private var starships: [Starship] = []
    
    var people2: [ObjectModel<NSManagedObject>] = []
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CoreDataManager.shared.isUpdate {
            contentView.reloadData()
            setup()
            CoreDataManager.shared.isUpdate = false
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        addSubviews()
        makeConstraints()
        contentViewModel = ContentViewModel()
//        people = contentViewModel.people
        people2 = contentViewModel.peopleModels
        planets = contentViewModel.planets
        starships = contentViewModel.starships
        configure(with: .init())
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func deleteFromDB(id: Int, type: SearchType) {
        switch type {
        case .person:
            contentViewModel.deletePerson(id: id)
//            people = contentViewModel.people
            people2 = contentViewModel.peopleModels
            contentView.reloadData()
            configure(with: .init())
        case .planet:
            contentViewModel.deletePlanet(id: id)
            planets = contentViewModel.planets
            contentView.reloadData()
            configure(with: .init())
        case .starship:
            contentViewModel.deleteStarship(id: id)
            starships = CoreDataManager.shared.fetchStarships()
            contentView.reloadData()
            configure(with: .init())
        default:
            break
        }
    }
}

// MARK: - Configurable
extension FavouritesViewController: Configurable {
    public typealias ViewModel = ContentViewModel
    
    public func configure(with viewModel: ViewModel) {
        people2.forEach { person in
            
            var infoValueViewModels: [InfoValueView.ViewModel] = []
            let dict = person.descriptionValue.sorted { $0.key > $1.key }
            dict.forEach { value in
                let infoValueViewModel: InfoValueView.ViewModel = .init(title: value.key, subtitle: value.value)
                infoValueViewModels.append(infoValueViewModel)
            }
            
            self.contentView.configure(
                with: .init(
                    id: person.id,
                    infoValueViewModels: infoValueViewModels,
                    searchType: .person
                )
            )
        }
        
        planets.forEach { planet in
            self.contentView.configure(
                with: .init(
                    id: Int(planet.id),
                    infoValueViewModels: [
                        .init(title: "Name: ", subtitle: planet.name ?? ""),
                        .init(title: "Diameter: ", subtitle: planet.diameter ?? ""),
                        .init(title: "Population: ", subtitle: planet.population ?? "")
                    ],
                    searchType: .planet
                )
            )
        }
        
        starships.forEach { starship in
            self.contentView.configure(
                with: .init(
                    id: Int(starship.id),
                    infoValueViewModels: [
                        .init(title: "Name: ", subtitle: starship.name ?? ""),
                        .init(title: "Model: ", subtitle: starship.model ?? ""),
                        .init(title: "Manufacturer: ", subtitle: starship.manufacturer ?? ""),
                        .init(title: "Passengers: ", subtitle: starship.passengers ?? "")
                    ],
                    searchType: .starship
                )
            )
        }
    }
}

// MARK: - ContentFavouritesProtocol
extension FavouritesViewController: ContentFavouritesProtocol {
    func fovouriteButtonTapped(isFovourite: Bool, id: Int, type: SearchType) {
        deleteFromDB(id: id, type: type)
    }
}
