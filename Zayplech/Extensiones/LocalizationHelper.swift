//
//  LocalizationHelper.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import Foundation

func t(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, arguments: args)
}
