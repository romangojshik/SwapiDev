//
//  InfoView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import UIKit

// MARK: - InfoFavouritesViewProtocol
public protocol InfoFavouritesViewProtocol: AnyObject {
    func fovouriteButtonTapped(isFovourite: Bool, id: Int)
}

public final class InfoFavouritesView: UIView {
    // MARK: - Public Properties

    weak var delegate: InfoFavouritesViewProtocol?
    
    // MARK: - Subview Properties
    
    private lazy var horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 20
    }
    
    private lazy var containerFavouriteButtonView = UIView()
    
    private lazy var favouriteButton = UIButton().then {
        $0.setImage(UIImage(named: "yellow_star"), for: .normal)
        $0.addTarget(self, action: #selector(addInFavourites), for: .touchUpInside)
    }
    
    private lazy var containerVerticalStackView = UIView()
    
    private lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 15
    }
        
    // MARK: - Private Properties
    
    private var isAddInFovourites = false
    private var idViewModel = 0
    private var infoValueViewModels: InfoValueView.ViewModel?
    
    // MARK: - UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        layer.cornerRadius = 12
        backgroundColor = .lightGray
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        containerFavouriteButtonView.addSubview(favouriteButton)
        containerVerticalStackView.addSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(containerVerticalStackView)
        horizontalStackView.addArrangedSubview(containerFavouriteButtonView)
        addSubview(horizontalStackView)
    }
    
    private func makeConstraints() {
        containerFavouriteButtonView.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        favouriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupInfoValueView(viewModel: InfoValueView.ViewModel) {
        let infoValueView = InfoValueView()
        infoValueView.configure(
            with: .init(title: viewModel.title, subtitle: viewModel.subtitle)
        )
        verticalStackView.addArrangedSubview(infoValueView)
    }
    
    private func makeAddInFovouritesButton() {
        isAddInFovourites
            ? favouriteButton.setImage(UIImage(named: "yellow_star"), for: .normal)
            : favouriteButton.setImage(UIImage(named: "favorite"), for: .normal)
    }
    
    @objc private func addInFavourites() {
        if !isAddInFovourites {
            isAddInFovourites = true
            delegate?.fovouriteButtonTapped(isFovourite: true, id: idViewModel)
        } else {
            isAddInFovourites = false
            delegate?.fovouriteButtonTapped(isFovourite: false, id: idViewModel)
        }
        makeAddInFovouritesButton()
    }
}

// MARK: - InfoFavouritesView

extension InfoFavouritesView: Configurable {
    public struct ViewModel {
        let id: Int
        let infoValueViewModels: InfoValueView.ViewModel
    }
    
    public func configure(with viewModel: ViewModel) {
        setupInfoValueView(viewModel: viewModel.infoValueViewModels)
        infoValueViewModels = viewModel.infoValueViewModels
        idViewModel = viewModel.id
    }
}

