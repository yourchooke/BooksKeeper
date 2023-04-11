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
   // var nextElement: Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.set(false, forKey: "bookKeeper") // Comment before send!!!!!! Just for testing!!!
        
        customActivityIndicator.spin(duration: Double.random(in: 2.0...5.0)) {
            self.customActivityIndicator.isHidden = true
            if !UserDefaults.standard.bool(forKey: "bookKeeper") {
                //     self.nameView.isHidden = false
                self.nameView.show {
                    self.logoView.show {
                        self.buttonStart.show()
                    }
                }
                UserDefaults.standard.set(true, forKey: "bookKeeper")
            } else {
                self.performSegue(withIdentifier: "fromLoader", sender: (Any).self)
            }
        }
            
    }

    

}

