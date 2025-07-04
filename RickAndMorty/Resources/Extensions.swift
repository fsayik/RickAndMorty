//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Ferhat Şayık on 2.07.2025.
//

import Foundation
import UIKit


extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach {
            addSubview($0)
        }
    }
}
