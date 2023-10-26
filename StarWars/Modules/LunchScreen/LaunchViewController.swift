//
//  LaunchViewController.swift
//  StarWars
//
//  Created by Roman on 10/26/23.
//

import SnapKit

class LaunchViewController: UIViewController {
    // MARK: - Subview Properties
    
    private lazy var imageView = UIImageView().then {
        $0.image = UIImage.init(named: "millennium_falcon")
    }
    
    // MARK: - Private Properties
    
    // MARK: - UIViewController
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { self.animate() })
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(imageView)
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
    }
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.width * 3
            let diffX  = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(x: -(diffX / 2), y: diffY / 2, width: size, height: size)
            self.imageView.alpha = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let home = MainTabBarViewController()
            home.modalTransitionStyle = .crossDissolve
            home.modalPresentationStyle = .fullScreen
            self.present(home, animated: true)
        })
    }
}
