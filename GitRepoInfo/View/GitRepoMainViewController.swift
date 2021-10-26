//
//  GitRepoMainViewController.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/25/21.
//

import UIKit

class GitRepoMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Set screen title on navigation bar
    
    func setNavigationTitle(screenTitle : String){
        self.title = screenTitle
    }
    
    
    //Common function to show alert according to passed parameters
    
    func showErrorMessage(title : String, message : String, buttonTitle : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {_ in}))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
