//
//  ContentView.swift
//  StarWars
//
//  Created by Roman on 9/2/23.
//

import SnapKit

// MARK: - ContentViewProtocol
protocol ContentViewProtocol: AnyObject {
    func getInfoButtonDidTap(inputText: String, parameterForSearch: SearchType)
    func fovouriteButtonTapped(isFovourite: Bool, type: SearchType)
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
        $0.spacing = 20
    }
    
    private lazy var personButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.isUserInteractionEnabled = false
        $0.setImage(UIImage(named: "person"), for: .normal)
        $0.layer.cornerRadius = 6
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(peopleButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var planetButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.isUserInteractionEnabled = false
        $0.setImage(UIImage(named: "planet"), for: .normal)
        $0.layer.cornerRadius = 6
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(planetButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var starshipButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.isUserInteractionEnabled = false
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
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var infoView = InfoView().then() {
        $0.delegate = self
        $0.isHidden = true
    }
    
    // MARK: - Private Properties
    
    private var inputString: String = ""
    private var parameterForSearch: SearchType?
    private var isPersonButtonEnabled = false
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
        horizontalStackView.addArrangedSubview(personButton)
        horizontalStackView.addArrangedSubview(planetButton)
        horizontalStackView.addArrangedSubview(starshipButton)
        addSubview(horizontalStackView)
        addSubview(getInfoButton)
        addSubview(activityIndicator)
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
            make.top.equalTo(inputTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        getInfoButton.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(getInfoButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        infoView.snp.makeConstraints { make in
            make.top.equalTo(getInfoButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    @objc private func getInfo() {
        guard let parameter = parameterForSearch  else { return }
        getInfoButton.setTitleColor(.lightGray, for: .highlighted)
        activityIndicator.startAnimating()
        delegate?.getInfoButtonDidTap(inputText: inputString, parameterForSearch: parameter)
    }
    
    @objc private func peopleButtonDidTap() {
        isPersonButtonEnabled = true
        isPlanetButtonEnabled = false
        isStarshipButtonEnabled = false
        configurePlanetButton()
        configureStarshipButton()
        personButton.backgroundColor = .blue
        personButton.setImage(UIImage(named: "color_person"), for: .normal)
        parameterForSearch = SearchType.person
        configureGetInfoButton(isEnabled: true)
    }
    
    @objc private func planetButtonDidTap() {
        isPersonButtonEnabled = false
        isPlanetButtonEnabled = true
        isStarshipButtonEnabled = false
        configurePersonButton()
        configureStarshipButton()
        planetButton.backgroundColor = .blue
        planetButton.setImage(UIImage(named: "color_planet"), for: .normal)
        parameterForSearch = SearchType.planet
        configureGetInfoButton(isEnabled: true)
    }
    
    @objc private func starshipButtonDidTap() {
        isPersonButtonEnabled = false
        isPlanetButtonEnabled = false
        isStarshipButtonEnabled = true
        configurePersonButton()
        configurePlanetButton()
        starshipButton.backgroundColor = .blue
        starshipButton.setImage(UIImage(named: "color_starship"), for: .normal)
        parameterForSearch = SearchType.starship
        configureGetInfoButton(isEnabled: true)
    }
    
    private func configurePersonButton() {
        personButton.backgroundColor = .lightGray
        personButton.setImage(UIImage(named: "person"), for: .normal)
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
            inputString.count > 2,
            parameterForSearch != nil
        {
            getInfoButton.backgroundColor = .blue
            getInfoButton.setTitleColor(.white, for: .normal)
            getInfoButton.isEnabled = true
        } else {
            getInfoButton.backgroundColor = .lightGray
            getInfoButton.setTitleColor(.lightText, for: .normal)
            getInfoButton.isEnabled = false
            
            configureParamButton(isEnabled: false)
            configurePersonButton()
            configurePlanetButton()
            configureStarshipButton()
        }
    }
    
    private func configureParamButton(isEnabled: Bool) {
        personButton.isUserInteractionEnabled = isEnabled
        planetButton.isUserInteractionEnabled = isEnabled
        starshipButton.isUserInteractionEnabled = isEnabled
    }
}

// MARK: - UITextFieldDelegate

extension ContentView: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField.text != "" else {
            inputString = textField.text ?? ""
            infoView.isHidden = true
            parameterForSearch = nil
            
            configurePersonButton()
            configurePlanetButton()
            configureStarshipButton()
            configureParamButton(isEnabled: false)
            configureGetInfoButton(isEnabled: false)
            activityIndicator.stopAnimating()
            
            return
        }
        inputString = textField.text ?? ""
        configureParamButton(isEnabled: true)
        guard parameterForSearch != nil else { return }
        configureGetInfoButton(isEnabled: true)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if
            let count = textField.text?.count,
            string == "",
            count <= 3
        {
            parameterForSearch = nil
            infoView.isHidden = true
            configureParamButton(isEnabled: false)
            configureGetInfoButton(isEnabled: false)
            activityIndicator.stopAnimating()
        }
        return true
    }
}

// MARK: - Configurable
extension ContentView: Configurable {
    public typealias ViewModel = ObjectModel
    
    public func configure(with viewModel: ViewModel) {
        switch viewModel.type {
        case .person:
            infoView.configure(
                with: .init(
                    id: viewModel.id ?? 0,
                    infoValueViewModels: [
                        .init(title: "Name: ", subtitle: viewModel.name ?? ""),
                        .init(title: "Gender: ", subtitle: viewModel.gender ?? "")
                    ],
                    searchType: .person
                )
            )
            activityIndicator.stopAnimating()
        case .planet:
            infoView.configure(
                with: .init(
                    id: viewModel.id ?? 0,
                    infoValueViewModels: [
                        .init(title: "Name: ", subtitle: viewModel.name ?? ""),
                        .init(title: "Diameter: ", subtitle: viewModel.diameter ?? ""),
                        .init(title: "Population: ", subtitle: viewModel.population ?? "")
                    ],
                    searchType: .planet
                )
            )
            activityIndicator.stopAnimating()
        case .starship:
            infoView.configure(
                with: .init(
                    id: viewModel.id ?? 0,
                    infoValueViewModels: [
                        .init(title: "Name: ", subtitle: viewModel.name ?? ""),
                        .init(title: "Model: ", subtitle: viewModel.model ?? ""),
                        .init(title: "Manufacturer: ", subtitle: viewModel.manufacturer ?? ""),
                        .init(title: "Passengers: ", subtitle: viewModel.passengers ?? "")
                    ],
                    searchType: .starship
                )
            )
            activityIndicator.stopAnimating()
        default:
            break
        }
        getInfoButton.isEnabled = !infoView.isHidden
        infoView.isHidden = false
    }
}

// MARK: - InfoViewProtocol
extension ContentView: InfoViewProtocol {
    public func fovouriteButtonTapped(isFovourite: Bool, type: SearchType) {
        guard let type = parameterForSearch else { return }
        delegate?.fovouriteButtonTapped(isFovourite: isFovourite, type: type)
    }
}
