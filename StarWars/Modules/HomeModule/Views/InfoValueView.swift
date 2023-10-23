//
//  InfoView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import SnapKit

public final class InfoValueView: UIView {
    
    // MARK: - Subview Properties
    
    private lazy var horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 15
    }
        
    private lazy var titleLabel = UILabel()
    
    private lazy var subtitleLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
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
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(subtitleLabel)
        addSubview(horizontalStackView)
    }

    private func makeConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Configurable

extension InfoValueView: Configurable {
    public struct ViewModel {
        let title: String
        let subtitle: String
    }

    public func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        let titleLabelWidht = titleLabel.intrinsicContentSize.width
        let subtitleLabelWidht = UIScreen.main.bounds.size.width - 30 - 20 - 15 - 20 - 24 - titleLabelWidht

        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(titleLabelWidht)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.width.equalTo(subtitleLabelWidht)
        }
    }
}
