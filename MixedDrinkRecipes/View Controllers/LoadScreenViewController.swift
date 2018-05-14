//
//  LoadScreenViewController.swift
//  MixedDrinkRecipes
//
//  Created by Alec Osborne on 5/12/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import UIKit

class LoadScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserModelController.shared.fetchCurrentUser { (success) in
            
            DispatchQueue.main.async {
                
                if success {
                    self.performSegue(withIdentifier: "toSignedInVC", sender: nil)
                }
                
                if !success {
                    self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
                }
            }
        }
    }
}
