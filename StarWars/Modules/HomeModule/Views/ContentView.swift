//
//  ContentView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import Foundation
import UIKit

protocol ContentViewProtocol: AnyObject {
    func getInfoButtonDidTap(inputText: String, parameterForSearch: SearchURL)
    func fovouriteButtonTapped(isFovourite: Bool)
}

public final class ContentView: UIView {
    // MARK: - Public Properties

    weak var delegate: ContentViewProtocol?

    // MARK: - Subview Properties
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Home"
        $0.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    private lazy var inputTextField = UITextField().then {
        $0.placeholder = "Enter a name"
        $0.backgroundColor = .lightGray
        $0.delegate = self
        $0.borderStyle = UITextField.BorderStyle.none
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.returnKeyType = UIReturnKeyType.done
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private lazy var horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 15
    }
    
    private lazy var peopleButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setImage(UIImage(named: "people"), for: .normal)
        $0.layer.cornerRadius = 6
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(peopleButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var planetButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setImage(UIImage(named: "planet"), for: .normal)
        $0.layer.cornerRadius = 6
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(planetButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var starshipButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setImage(UIImage(named: "starship"), for: .normal)
        $0.layer.cornerRadius = 6
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(starshipButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var getInfoButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.isEnabled = false
        $0.setTitle("Get information", for: .normal)
        $0.setTitleColor(.lightText, for: .normal)
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(getInfo), for: .touchUpInside)
    }
    
    private lazy var infoView = InfoView().then() {
        $0.delegate = self
        $0.isHidden = true
    }
        
    // MARK: - Private Properties
    
    private var isSearch = false
    private var inputString: String = ""
    private var parameterForSearch: SearchURL?
    private var isPeopleButtonEnabled = false
    private var isStarshipButtonEnabled = false
    private var isPlanetButtonEnabled = false
    
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
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(inputTextField)
        horizontalStackView.addArrangedSubview(peopleButton)
        horizontalStackView.addArrangedSubview(planetButton)
        horizontalStackView.addArrangedSubview(starshipButton)
        addSubview(horizontalStackView)
        addSubview(getInfoButton)
        addSubview(infoView)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(200)
            make.leading.trailing.equalToSuperview().inset(100)
            make.height.equalTo(40)
        }
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        getInfoButton.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        infoView.snp.makeConstraints { make in
            make.top.equalTo(getInfoButton.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    @objc private func getInfo() {
        guard let parameter = parameterForSearch  else { return }
        delegate?.getInfoButtonDidTap(inputText: inputString, parameterForSearch: parameter)
        inputString = ""
    }
    
    @objc private func peopleButtonDidTap() {
        isPeopleButtonEnabled = true
        isPlanetButtonEnabled = false
        isStarshipButtonEnabled = false
        configurePeopleButton()
        configurePlanetButton()
        configureStarshipButton()
        peopleButton.backgroundColor = .blue
        peopleButton.setImage(UIImage(named: "color_people"), for: .normal)
        parameterForSearch = SearchURL.people
        configureGetInfoButton(isEnabled: true)
    }
    
    @objc private func planetButtonDidTap() {
        isPeopleButtonEnabled = false
        isPlanetButtonEnabled = true
        isStarshipButtonEnabled = false
        configurePeopleButton()
        configurePlanetButton()
        configureStarshipButton()
        planetButton.backgroundColor = .blue
        planetButton.setImage(UIImage(named: "color_planet"), for: .normal)
        parameterForSearch = SearchURL.planet
        configureGetInfoButton(isEnabled: true)
    }
    
    @objc private func starshipButtonDidTap() {
        isPeopleButtonEnabled = false
        isPlanetButtonEnabled = false
        isStarshipButtonEnabled = true
        configurePeopleButton()
        configurePlanetButton()
        configureStarshipButton()
        starshipButton.backgroundColor = .blue
        starshipButton.setImage(UIImage(named: "color_starship"), for: .normal)
        parameterForSearch = SearchURL.starsShip
        configureGetInfoButton(isEnabled: true)
    }
    
    private func configurePeopleButton() {
        peopleButton.backgroundColor = .lightGray
        peopleButton.setImage(UIImage(named: "people"), for: .normal)
    }
    
    private func configurePlanetButton() {
        planetButton.backgroundColor = .lightGray
        planetButton.setImage(UIImage(named: "planet"), for: .normal)
    }
    
    private func configureStarshipButton() {
        starshipButton.backgroundColor = .lightGray
        starshipButton.setImage(UIImage(named: "starship"), for: .normal)
    }
    
    private func configureGetInfoButton(isEnabled: Bool) {
        if
            isEnabled,
            inputString.count > 2
        {
            getInfoButton.backgroundColor = .blue
            getInfoButton.setTitleColor(.white, for: .normal)
            getInfoButton.isEnabled = true
        } else {
            getInfoButton.backgroundColor = .lightGray
            getInfoButton.setTitleColor(.lightText, for: .normal)
            getInfoButton.isEnabled = false
        }
    }
}

extension ContentView: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField.text != "" else {
            inputString = textField.text ?? ""
            infoView.isHidden = true
            isPeopleButtonEnabled = false
            isPlanetButtonEnabled = false
            isStarshipButtonEnabled = false
            configurePeopleButton()
            configurePlanetButton()
            configureStarshipButton()
            return
        }
        inputString = textField.text ?? ""
        configureGetInfoButton(isEnabled: true)
        isSearch = true
    }
}

// MARK: - Configurable

extension ContentView: Configurable {
    public typealias ViewModel = ContentViewModel
    
    public func configure(with viewModel: ViewModel) {
        infoView.configure(
            with: .init(
                id: viewModel.id ?? 0,
                infoValueViewModels: [
                    .init(title: "Name: ", subtitle: viewModel.name ?? ""),
                    .init(title: "Gender: ", subtitle: viewModel.gender ?? "")
                ]
            )
        )
        infoView.isHidden = false
        isSearch = false
    }
}

// MARK: - InfoViewProtocol

extension ContentView: InfoViewProtocol {
    public func fovouriteButtonTapped(isFovourite: Bool) {
        delegate?.fovouriteButtonTapped(isFovourite: isFovourite)
    }
}
