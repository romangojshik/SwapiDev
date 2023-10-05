//
//  InfoView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import Foundation
import UIKit

//MARK: - ContentFavouritesProtocol

protocol ContentFavouritesProtocol: AnyObject {
    func fovouriteButtonTapped(isFovourite: Bool, id: Int)
}

public final class ContentFavouritesView: UIView {
    // MARK: - Public Properties
    
    weak var delegate: ContentFavouritesProtocol?
    
    // MARK: - Subview Properties
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Favourite"
        $0.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    private lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 15
        $0.backgroundColor = .orange
    }
    
    // MARK: - Private Properties
    
    private var id: Int = 0
    
    // MARK: - UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func reloadData() {
        verticalStackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        layer.cornerRadius = 12
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(verticalStackView)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.bottom.lessThanOrEqualToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupInfoValueView(viewModels: [InfoValueView.ViewModel]) {
        let infoFavouritesView = InfoFavouritesView()
        viewModels.forEach { viewModel in
            infoFavouritesView.delegate = self
            infoFavouritesView.configure(
                with: .init(id: id, infoValueViewModels: viewModel)
            )
        }
        verticalStackView.addArrangedSubview(infoFavouritesView)
    }
}

// MARK: - Configurable

extension ContentFavouritesView: Configurable {
    public struct ViewModel {
        let id: Int
        let infoValueViewModels: [InfoValueView.ViewModel]
    }
    
    public func configure(with viewModel: ViewModel) {
        id = viewModel.id
        setupInfoValueView(viewModels: viewModel.infoValueViewModels)
    }
}

// MARK: - InfoFavouritesViewProtocol

extension ContentFavouritesView: InfoFavouritesViewProtocol {
    public func fovouriteButtonTapped(isFovourite: Bool, id: Int) {
        delegate?.fovouriteButtonTapped(isFovourite: isFovourite, id: id)
    }
}
