//
//  Utilities.swift
//  MyWeatherApp
//
//  Created by Milan Parađina on 24.10.2022..
//

import Foundation
import CoreLocation
import UIKit

class Utilities {
    func getHours() -> Int {
        return Calendar.current.component(.hour, from: Date())
    }
}

//MARK: Localization
extension String {
    func localized(key: String) -> String {
        return NSLocalizedString(key, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
