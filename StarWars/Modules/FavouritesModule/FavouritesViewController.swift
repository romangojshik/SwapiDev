//
//  FavouritesViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import SnapKit
import CoreData

final class FavouritesViewController: UIViewController {
    // MARK: - Subview Properties
    
    private lazy var contentView = ContentFavouritesView().then {
        $0.delegate = self
    }
    
    // MARK: - Private Properties
    
    private var contentViewModel = ContentViewModel()
    private let apiService = ApiService()
    private var isReloadContent = false
    
    private var people: [FactoryObjectModel<NSManagedObject>] = []
    private var planets: [FactoryObjectModel<NSManagedObject>] = []
    private var starships: [FactoryObjectModel<NSManagedObject>] = []
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
//        CoreDataManager.shared.deleteAllPerson()
//        CoreDataManager.shared.deleteAllStarships()
//        CoreDataManager.shared.deleteAllPlanets()
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
        people = contentViewModel.peopleModels
        planets = contentViewModel.planetModels
        starships = contentViewModel.starshipModels
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
            people = contentViewModel.peopleModels
            contentView.reloadData()
            configure(with: .init())
        case .planet:
            contentViewModel.deletePlanet(id: id)
            planets = contentViewModel.peopleModels
            contentView.reloadData()
            configure(with: .init())
        case .starship:
            contentViewModel.deleteStarship(id: id)
            starships = contentViewModel.peopleModels
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
        /// Person
        people.forEach { person in
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
        /// Planets
        planets.forEach { planet in
            var infoValueViewModels: [InfoValueView.ViewModel] = []
            let dict = planet.descriptionValue.sorted { $0.key > $1.key }
            dict.forEach { value in
                let infoValueViewModel: InfoValueView.ViewModel = .init(title: value.key, subtitle: value.value)
                infoValueViewModels.append(infoValueViewModel)
            }
            self.contentView.configure(
                with: .init(
                    id: planet.id,
                    infoValueViewModels: infoValueViewModels,
                    searchType: .planet
                )
            )
        }
        /// Starships
        starships.forEach { starship in
            var infoValueViewModels: [InfoValueView.ViewModel] = []
            let dict = starship.descriptionValue.sorted { $0.key > $1.key }
            dict.forEach { value in
                let infoValueViewModel: InfoValueView.ViewModel = .init(title: value.key, subtitle: value.value)
                infoValueViewModels.append(infoValueViewModel)
            }
            self.contentView.configure(
                with: .init(
                    id: starship.id,
                    infoValueViewModels: infoValueViewModels,
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
