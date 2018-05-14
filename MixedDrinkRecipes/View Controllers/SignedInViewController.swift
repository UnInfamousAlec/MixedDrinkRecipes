//
//  SignedInViewController.swift
//  MixedDrinkRecipes
//
//  Created by Alec Osborne on 5/12/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import UIKit

class SignedInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userFirstNameLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let loggedInUser = UserModelController.shared.loggedInUser else { return }
        
        userFirstNameLabel.text = "\(loggedInUser.firstName)"
    }

}
