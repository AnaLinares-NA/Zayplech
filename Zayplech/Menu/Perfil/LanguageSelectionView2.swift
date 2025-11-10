//
//  LanguageSelectionView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

struct Language2: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let flag: String
}

struct LanguageSelectionView2: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "es"
    @State private var navigateToOnboarding = false
    @EnvironmentObject var localizationManager: LocalizationManager
    
    
    
    private let languages2: [Language] = [
        Language(code: "es", name: "Español", flag: "🇲🇽"),
        Language(code: "en", name: "English", flag: "🇺🇸"),
        Language(code: "fr", name: "Français", flag: "🇫🇷"),
        Language(code: "de", name: "Deutsch", flag: "🇩🇪"),
        Language(code: "pt", name: "Português", flag: "🇧🇷"),
        Language(code: "it", name: "Italiano", flag: "🇮🇹"),
        Language(code: "ja", name: "日本語", flag: "🇯🇵"),
        Language(code: "ar", name: "العربية", flag: "🇸🇦"),
        Language(code: "zh-Hans", name: "简体中文", flag: "🇨🇳"),
        Language(code: "ru", name: "Русский", flag: "🇷🇺")     
    ]

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                Text("Cambiar idioma")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.moradoMedio)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 20)]) {
                        ForEach(languages2) { lang in
                            Button(action: {
                                selectLanguage(lang.code)
                            }) {
                                VStack(spacing: 10) {
                                    Text(lang.flag)
                                        .font(.system(size: 40))
                                    Text(lang.name)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity, minHeight: 110)
                                .background()
                                .cornerRadius(14)
                                .shadow(radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .background()
            .navigationDestination(isPresented: $navigateToOnboarding) {
                PerfilView()
                    .environmentObject(localizationManager)
            }
        }
    }
    
    func selectLanguage(_ code: String) {
        selectedLanguage = code
        localizationManager.setLanguage(code)
        navigateToOnboarding = true
    }
}


#Preview {
    LanguageSelectionView2()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
        .previewDisplayName("Español")
}
