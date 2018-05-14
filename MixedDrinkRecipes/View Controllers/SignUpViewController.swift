//
//  SignUpViewController.swift
//  MixedDrinkRecipes
//
//  Created by Alec Osborne on 5/12/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    
    
    // MARK: - Actions
    @IBAction func userSignUpButtonPressed(_ sender: UIButton) {
        
        guard let emailAddress = userEmailAddressTextField.text, !emailAddress.isEmpty,
            let firstName = userFirstNameTextField.text, !firstName.isEmpty,
            let lastName = userLastNameTextField.text, !lastName.isEmpty
            else { return }
        
        UserModelController.shared.createNewUserWith(emailAddress: emailAddress, firstName: firstName, lastName: lastName) { (success) in
            
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "fromSignUpToSignedInVC", sender: nil)
                }
            }
            
            if !success {
                print("Error pulling user")
            }
        }
    }
}
