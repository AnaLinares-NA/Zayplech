//
//  LocalizationManager.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import Foundation
import SwiftUI
import Combine

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()

    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
            Bundle.setLanguage(currentLanguage)
        }
    }

    private init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "es"
        Bundle.setLanguage(currentLanguage)
    }

    func setLanguage(_ language: String) {
        self.currentLanguage = language
    }
}

// MARK: - Bundle Swizzling para Localización Manual

private var bundleKey: UInt8 = 0

class LocalizedBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
              let bundle = Bundle(path: path) else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    static func setLanguage(_ language: String) {
        object_setClass(Bundle.main, type(of: LocalizedBundle()))
        if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
            objc_setAssociatedObject(Bundle.main, &bundleKey, path, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
