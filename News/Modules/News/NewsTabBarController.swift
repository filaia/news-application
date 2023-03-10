//
//  NewsTabBarController.swift
//  News
//
//  Created by Philip on 11.03.2023.
//

import UIKit

final class NewsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }
    
    private func setupTabs() {
        let newsViewController = NewsViewController()
        let favouriteViewController = FavouriteViewController()
        
        let newsNavigation = UINavigationController(rootViewController: newsViewController)
        let favouriteNavigation = UINavigationController(rootViewController: favouriteViewController)
        
        let navigations = [newsNavigation, favouriteNavigation]
        
        setViewControllers(navigations, animated: true)

        newsViewController.title = "News"
        favouriteViewController.title = "Favourites"
        
        newsNavigation.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: Icon.newspaper.rawValue), selectedImage: UIImage(systemName: Icon.newspaperSelected.rawValue))
        
        favouriteNavigation.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: Icon.favourite.rawValue), selectedImage: UIImage(systemName: Icon.favouriteSelected.rawValue))
        
        for navigation in navigations {
            navigation.navigationBar.prefersLargeTitles = true
            navigation.view.backgroundColor = .white
        }
    }
}
