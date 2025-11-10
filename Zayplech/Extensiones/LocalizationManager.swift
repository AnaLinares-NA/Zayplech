//
//  LocalizationManager.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI
import Combine

final class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
            Bundle.setLanguage(currentLanguage)
            objectWillChange.send() // ✅ fuerza actualización en las vistas SwiftUI
        }
    }
    
    private init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "es"
        Bundle.setLanguage(currentLanguage)
    }
    
    func setLanguage(_ language: String) {
        guard language != currentLanguage else { return }
        currentLanguage = language
    }
}

// MARK: - Bundle Swizzling para Localización Manual

private var bundleKey: UInt8 = 0

extension Bundle {
    class func setLanguage(_ language: String) {
        defer { object_setClass(Bundle.main, PrivateBundle.self) }
        let path = Bundle.main.path(forResource: language, ofType: "lproj") ?? ""
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: path), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private class PrivateBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

