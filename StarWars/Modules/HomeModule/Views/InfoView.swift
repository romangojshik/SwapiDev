//
//  InfoView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import SnapKit

// MARK: - InfoViewProtocol

public protocol InfoViewProtocol: AnyObject {
    func fovouriteButtonTapped(isFovourite: Bool)
}

public final class InfoView: UIView {
    // MARK: - Public Properties
    
    weak var delegate: InfoViewProtocol?
    
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
            delegate?.fovouriteButtonTapped(isFovourite: true)
        } else {
            isAddInFovourites = false
            delegate?.fovouriteButtonTapped(isFovourite: false)
        }
        makeAddInFovouritesButton()
    }
    
}

// MARK: - Configurable

extension InfoView: Configurable {
    public struct ViewModel {
        let id: Int
        let infoValueViewModels: [InfoValueView.ViewModel]
    }
    
    public func configure(with viewModel: ViewModel) {
        verticalStackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        setupInfoValueView(viewModels: viewModel.infoValueViewModels)
    }
}

