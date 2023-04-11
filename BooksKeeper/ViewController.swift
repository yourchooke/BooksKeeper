//
//  ViewController.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 06.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var customActivityIndicator: UIImageView!
    @IBOutlet weak var nameView: UIImageView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var buttonStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customActivityIndicator.spin(duration: 5.0) {
            self.customActivityIndicator.isHidden = true
            if !UserDefaults.standard.bool(forKey: "bookKeeper") {
                self.nameView.isHidden = false
                self.logoView.isHidden = false
                self.buttonStart.isHidden = false
                UserDefaults.standard.set(true, forKey: "bookKeeper")
            } else {
                self.performSegue(withIdentifier: "fromLoader", sender: (Any).self)
            }
        }
            
    }

    

}

