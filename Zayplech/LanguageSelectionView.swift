//
//  LanguageSelectionView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

struct Language: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let flag: String
}

struct LanguageSelectionView: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "es"
    @State private var navigateToOnboarding = false
    @EnvironmentObject var localizationManager: LocalizationManager
    
    private let languages: [Language] = [
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
            ZStack {

                VStack(spacing: 35) {
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Text("Selecciona tu idioma")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.rosaFucsiaOscuro, .rosaChicle],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )

                        Text("Podrás cambiarlo más adelante")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 130), spacing: 20)]) {
                            ForEach(languages) { lang in
                                LanguageButton(
                                    language: lang,
                                    isSelected: selectedLanguage == lang.code
                                ) { withAnimation(.easeInOut(duration: 0.3)) {
                                        selectLanguage(lang.code) } }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                    
                    Button {
                        navigateToOnboarding = true
                    } label: {
                        Text("Continuar")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 80)
                            .padding(.vertical, 14)
                            .background(
                                LinearGradient(
                                    colors: [.rosaMagenta, .rosaChicle],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .opacity(selectedLanguage.isEmpty ? 0.6 : 1)
                    .disabled(selectedLanguage.isEmpty)
                    .padding(.bottom, 30)
                }
                .padding(.top, 20)
            }
            .navigationDestination(isPresented: $navigateToOnboarding) {
                EventoSelectionView()
                    .environmentObject(localizationManager)
            }
        }
    }

    func selectLanguage(_ code: String) {
        selectedLanguage = code
        localizationManager.setLanguage(code)
    }
}

// MARK: - Subview para cada botón
struct LanguageButton: View {
    let language: Language
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(language.flag)
                    .font(.system(size: 40))
                Text(language.name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, minHeight: 110)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(1.20))
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected
                        ? AnyShapeStyle(LinearGradient(
                            colors: [.rosaMagenta, .rosaChicle],
                            startPoint: .leading,
                            endPoint: .trailing
                        )) : AnyShapeStyle(Color.clear), lineWidth: 3
                    )
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
        }
    }
}

#Preview {
    LanguageSelectionView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
