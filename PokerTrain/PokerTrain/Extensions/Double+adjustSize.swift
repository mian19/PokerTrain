//
//  Double+adjustSize.swift
//  ImageSearcher
//
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
