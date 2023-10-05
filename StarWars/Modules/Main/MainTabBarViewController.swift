//
//  ViewController.swift
//  StarWars
//
//  Created by Roman on 8/31/23.
//

import UIKit
import SnapKit
import Alamofire

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        
        generateTabBar()
        
    }
    
        
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
                image: UIImage(named: "favorite")
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

