//
//  FavouritesViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import UIKit
import Alamofire

class FavouritesViewController: UIViewController {
    
    // MARK: - Subview Properties
    
    private lazy var contentView = ContentFavouritesView().then {
        $0.delegate = self
    }
    
    // MARK: - Private Properties
    
    private var contentViewModel = ContentViewModel()
    private let apiService = ApiService()
    private var isReloadContent = false
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        addSubviews()
        makeConstraints()
        configure(with: contentViewModel)
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
        contentView.reloadData()
        configure(with: contentViewModel)
    }
}

// MARK: - Configurable

extension FavouritesViewController: Configurable {
    public typealias ViewModel = ContentViewModel
    
    public func configure(with viewModel: ViewModel) {
        let people = CoreDataManager.shared.fetchPeople()
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
        print("id", id)
        deleteFromDB(id: id)
    }
}
