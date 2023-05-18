//
//  UIStoryboardAppExtension.swift
//  City Search
//
//  Created by Kaung Htet Win on 16/5/2566 BE.
//

import UIKit

extension UIStoryboard {
    enum StoryBoard: String {
        case Main
        func instance(_ vc: String) -> UIViewController {
            return UIStoryboard(name: self.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: vc)
        }
    }
    
    // MARK: - Main StoryBoard
    class func cityDetailsViewController() -> CityDetailsViewController? {
        return StoryBoard.Main.instance(CityDetailsViewController.className) as? CityDetailsViewController
    }
    
    class func homeViewController() -> HomeViewController? {
        return StoryBoard.Main.instance(HomeViewController.className) as? HomeViewController
    }
}
