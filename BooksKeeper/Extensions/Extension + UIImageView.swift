//
//  Extension + UIImageView.swift
//  BooksKeeper
//
//  Created by Olga Yurchuk on 11.04.2023.
//

import UIKit

extension UIImageView {
    func spin(duration: CFTimeInterval = 2, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let spin = CABasicAnimation(keyPath: "transform.rotation")
        let radians = CGFloat.pi / 4
        spin.fromValue = radians
        spin.toValue = radians + .pi
        spin.isRemovedOnCompletion = false
        spin.duration = duration
        spin.repeatCount = 1
        
        self.layer.add(spin, forKey: nil)
        
        CATransaction.commit()
    }
    
    func show(completion: @escaping () -> Void){
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let show = CABasicAnimation(keyPath:"transform.scale")
        self.isHidden = false
        show.duration = 1
        show.fromValue = 0
        show.toValue = 1
        
        self.layer.add(show, forKey: nil)
        CATransaction.commit()
    }
}
