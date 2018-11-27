//
//  HandyCategories.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import RealmSwift

//get wordform of int
extension Int {
    
    func formatFrom(wordForms: [String]) -> String {
        guard wordForms.count == 3 else {
            return ""
        }
        
        let n = labs(self) % 100
        let n1 = labs(self) % 10
        if n > 10 && n < 20 {
            return wordForms[2]
        } else if n1 > 1 && n1 < 5 {
            return wordForms[1]
        } else if n1 == 1 {
            return wordForms[0]
        }
        return wordForms.last!
    }
}

//rounds the double to decimal places value
extension Double {
    
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//logging error data of alamofire response
extension DataResponse {
    
    func logError() {
        let url = request?.url?.absoluteString ?? ""
        print("\nFailed request: \(url)")
        guard let errorData = self.data else { return }
        let errorString = String(data: errorData, encoding: .utf8) ?? ""
        print("Error : \(errorString)")
    }
    
    func getErrorString() -> String? {
        guard let errorData = self.data else { return nil }
        return String(data: errorData, encoding: .utf8) ?? ""
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension Results {
    func toArray() -> [Element] {
        return Array(self)
    }
}

extension Int {
    mutating func increment() -> Int {
        self += 1
        return self
    }
}
