//
//  ContentFavouritesView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import SnapKit

// MARK: - ContentFavouritesProtocol
protocol ContentFavouritesProtocol: AnyObject {
    func fovouriteButtonTapped(isFovourite: Bool, id: Int, type: SearchType)
}

public final class ContentFavouritesView: UIView {
    // MARK: - Public Properties
    
    weak var delegate: ContentFavouritesProtocol?
    
    // MARK: - Subview Properties
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Favourite"
        $0.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    private lazy var containerView = UIView()
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    private lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 15
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
        containerView.addSubview(verticalStackView)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupInfoValueView(viewModels: [InfoValueView.ViewModel], searchType: SearchType) {
        let infoFavouritesView = InfoFavouritesView()
        viewModels.forEach { viewModel in
            infoFavouritesView.delegate = self
            infoFavouritesView.configure(
                with: .init(id: id, infoValueViewModels: viewModel, searchType: searchType)
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
        let searchType: SearchType
    }
    
    public func configure(with viewModel: ViewModel) {
        id = viewModel.id
        setupInfoValueView(viewModels: viewModel.infoValueViewModels, searchType: viewModel.searchType)
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(verticalStackView.snp.height).offset(20)
        }
    }
}

// MARK: - InfoFavouritesViewProtocol
extension ContentFavouritesView: InfoFavouritesViewProtocol {
    public func fovouriteButtonTapped(isFovourite: Bool, id: Int, type: SearchType) {
        delegate?.fovouriteButtonTapped(isFovourite: isFovourite, id: id, type: type)
    }
}
