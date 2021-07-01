//
//  SpinnerExtention.swift
//  SoftxpertRecipes
//
//  Created by YehiaAzab on 30/06/2021.
//

import Foundation
import UIKit

fileprivate var aView:UIView?


extension UIViewController{
    
    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(white: 0.6, alpha: 0.2)
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func stopSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
    
}
