//
//  NumberFormatter+USCurrency.swift
//  ScottishPowerTest
//
//  Created by Stephen Biggerstaff on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    class func USCurrencyFormatter() -> NumberFormatter {

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_US") // This is an assumption based on the API returning american prices.
        return numberFormatter
    }
}
