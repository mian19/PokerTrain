//
//  Double+adjustSize.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//
import UIKit

extension Double {
    func adjW() -> Double {
        let iPhone13ProMaxScreenWidth = 428 / self
        return UIScreen.main.bounds.width / iPhone13ProMaxScreenWidth
    }
    
    func adjH() -> Double {
        let iPhone13ProMaxScreenHeight = 926 / self
        return UIScreen.main.bounds.width / iPhone13ProMaxScreenHeight
    }
}
