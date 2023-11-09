//
//  InfoView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import SnapKit

public final class InfoView: UIView {
    // MARK: - Public Properties
    
    var fovouriteButtonHandler: ((Bool, SearchType) -> ())?
    
    // MARK: - Subview Properties
    
    private lazy var favouriteButton = UIButton().then {
        $0.setImage(UIImage(named: "favourite"), for: .normal)
        $0.addTarget(self, action: #selector(addInFovourites), for: .touchUpInside)
    }
    
    private lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 15
    }
    
    // MARK: - Private Properties
    
    private var isAddInFovourites = false
    private var searchType: SearchType = .none
    
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
        addSubview(favouriteButton)
        addSubview(verticalStackView)
    }
    
    private func makeConstraints() {
        favouriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(verticalStackView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(24)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
        }
    }
    
    private func setupInfoValueView(viewModels: [InfoValueView.ViewModel]) {
        viewModels.forEach { viewModel in
            let infoValueView = InfoValueView()
            infoValueView.configure(
                with: .init(title: viewModel.title, subtitle: viewModel.subtitle)
            )
            verticalStackView.addArrangedSubview(infoValueView)
        }
    }
    
    private func makeAddInFovouritesButton() {
        isAddInFovourites
            ? favouriteButton.setImage(UIImage(named: "yellow_star"), for: .normal)
            : favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
    }
    
    @objc private func addInFovourites() {
        if !isAddInFovourites {
            isAddInFovourites = true
            fovouriteButtonHandler?(true, searchType)
        } else {
            isAddInFovourites = false
            fovouriteButtonHandler?(false, searchType)
        }
        makeAddInFovouritesButton()
    }
    
}

// MARK: - Configurable
extension InfoView: Configurable {
    public struct ViewModel {
        let id: Int
        let infoValueViewModels: [InfoValueView.ViewModel]
        let searchType: SearchType
    }
    
    public func configure(with viewModel: ViewModel) {
        verticalStackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        searchType = viewModel.searchType
        setupInfoValueView(viewModels: viewModel.infoValueViewModels)
    }
}

