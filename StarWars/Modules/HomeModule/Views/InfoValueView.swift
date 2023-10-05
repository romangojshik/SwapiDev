//
//  InfoView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import Foundation
import UIKit

public final class InfoValueView: UIView {
    
    // MARK: - Subview Properties
    
    private lazy var horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 15
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Value: "
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.text = "-"
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
    }
}
