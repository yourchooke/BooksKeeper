//
//  Extension + UIbutton.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 11.04.2023.
//

import UIKit

extension UIButton {
    func show() -> Void {
        let show = CABasicAnimation(keyPath:"transform.scale")
        self.isHidden = false
        show.duration = 1
        show.fromValue = 0
        show.toValue = 1
        
        self.layer.add(show, forKey: nil)
    }
}
