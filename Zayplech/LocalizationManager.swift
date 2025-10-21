import Foundation
import SwiftUI

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
}
