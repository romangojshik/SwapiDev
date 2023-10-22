//
//  FavouritesViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import SnapKit

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
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CoreDataManager.shared.isUpdate {
            contentView.reloadData()
            people = CoreDataManager.shared.fetchPeople()
            configure(with: .init(people: people))
            CoreDataManager.shared.isUpdate = false
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        addSubviews()
        makeConstraints()
        people = CoreDataManager.shared.fetchPeople()
        configure(with: .init(people: people))
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func deleteFromDB(id: Int) {
        CoreDataManager.shared.deletePerson(id: Int32(id))
        people = CoreDataManager.shared.fetchPeople()
        contentView.reloadData()
        configure(with: .init(people: people))
    }
}

// MARK: - Configurable

extension FavouritesViewController: Configurable {
    public typealias ViewModel = ContentViewModel
    
    public func configure(with viewModel: ViewModel) {
        people.forEach { person in
            switch person {
            case person as Person:
                self.contentView.configure(
                    with: .init(
                        id: Int(person.id),
                        infoValueViewModels: [
                            .init(title: "Name: ", subtitle: person.name ?? ""),
                            .init(title: "Gender: ", subtitle: person.gender ?? "")
                        ]
                    )
                )
            default:
                print("")
            }
        }
    }
}

// MARK: - ContentFavouritesProtocol

extension FavouritesViewController: ContentFavouritesProtocol {
    func fovouriteButtonTapped(isFovourite: Bool, id: Int) {
        deleteFromDB(id: id)
    }
}
