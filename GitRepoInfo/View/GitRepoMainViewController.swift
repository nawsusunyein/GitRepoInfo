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
    
    func setNavigationTitle(screenTitle : String){
        self.title = screenTitle
    }
    
    func showErrorMessage(title : String, message : String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
        self.present(alertController, animated: true, completion: nil)
    }

  

}
