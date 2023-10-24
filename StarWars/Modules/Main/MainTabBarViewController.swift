//
//  MainTabBarViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        generateTabBar()
        
    }
    // MARK: - Private Methods

    private func addSubviews() {}

    private func makeConstraints() {}

    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: HomeViewController(),
                title: "Home",
                image: UIImage(named: "home")
            ),
            generateVC(
                viewController: FavouritesViewController(),
                title: "Favorite",
                image: UIImage(named: "favourite")
            )
        ]
    }
    
    private func generateVC(
        viewController: UIViewController,
        title: String,
        image: UIImage?
    ) -> UIViewController
    {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}

