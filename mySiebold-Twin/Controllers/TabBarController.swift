//
//  TabBarController.swift
//  mySiebold-Twin
//
//  Created by Lukas Ackermann on 30.03.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    private func setupViewControllers() {
        tabBar.self.tintColor = UIColor .white
        let appointmentsVC = AppointmentsViewController()
        appointmentsVC.tabBarItem = UITabBarItem(title: "Appointments", image: UIImage(systemName: "calendar"), tag: 0)
        
        let substitutionsVC = SubstitutionPlanViewController()
        substitutionsVC.tabBarItem = UITabBarItem(title: "Substitutions", image: UIImage(systemName: "calendar.day.timeline.right"), tag: 1)

        let navigationController1 = UINavigationController(rootViewController: appointmentsVC)
        
        let navigationController2 = UINavigationController(rootViewController: substitutionsVC)
        
        setViewControllers([navigationController1, navigationController2], animated: false)

    }
}
