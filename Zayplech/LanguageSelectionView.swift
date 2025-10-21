//
//  LanguageSelectionView.swift
//

import SwiftUI

struct LanguageSelectionView: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "es"
    @State private var navigateToOnboarding = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Selecciona tu idioma")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                LanguageButton(languageCode: "es", label: "Español", action: selectLanguage)
                LanguageButton(languageCode: "en", label: "English", action: selectLanguage)
                LanguageButton(languageCode: "fr", label: "Français", action: selectLanguage)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.blanco.ignoresSafeArea())
        .navigationDestination(isPresented: $navigateToOnboarding) {
            ContentView()
        }
    }
    
    func selectLanguage(_ code: String) {
        selectedLanguage = code
        navigateToOnboarding = true
    }
}

struct LanguageButton: View {
    var languageCode: String
    var label: String
    var action: (String) -> Void

    var body: some View {
        Button(action: {
            action(languageCode)
        }) {
            Text(label)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.naranjaMelocoton)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 3)
        }
        .padding(.horizontal, 30)
    }
}
