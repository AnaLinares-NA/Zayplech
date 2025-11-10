//
//  MenuView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

struct MenuView: View {
    @Binding var showMenu: Bool
    @Binding var selectedTab: Tab
    @Binding var goToTusIntereses: Bool
    @Binding var goToSalud: Bool
    @EnvironmentObject var localizationManager: LocalizationManager
    @State private var showLanguageMenu = false
    
    let idiomas = [
        "en": "English",
        "fr": "Français",
        "de": "Deutsch",
        "it": "Italiano",
        "pt": "Português",
        "ja": "日本語",
        "ar": "العربية",
        "zh-Hans": "简体中文",
        "ru": "Русский",
        "es": "Español"
    ]
    
    var body: some View {
        ZStack {
            
            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        showMenu = false
                    }
                }
            
            ZStack {
                LinearGradient(
                        gradient: Gradient(colors: [.rosaChicle, .rosaMagenta]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                )
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                showMenu = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.rosaFucsiaOscuro)
                        }
                    }
                    
                    if showLanguageMenu {
                        languageSubmenu
                    } else {
                        mainMenu
                    }
                    
                    NavigationLink(destination: SaludView(), isActive: $goToSalud) { EmptyView() }
                    NavigationLink(destination: TusInteresesView(), isActive: $goToTusIntereses) { EmptyView() }

                    Spacer()
                }
                .frame(width: 250)
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
            }
            .offset(x: showMenu ? 0 : -300)
            .scaleEffect(showMenu ? 1 : 0.95)
            .opacity(showMenu ? 1 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: showMenu)
        }
    }
    
    // MARK: - Subvistas
    
    private var languageSubmenu: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: { withAnimation { showLanguageMenu = false } }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Menú")
                }
                .foregroundColor(.rosaFucsiaOscuro)
            }
            .padding(.bottom, 10)
            
            ForEach(idiomas.sorted(by: { $0.value < $1.value }), id: \.key) { key, value in
                Button(action: {
                    localizationManager.setLanguage(key)
                    withAnimation(.easeInOut) {
                        showMenu = false
                        showLanguageMenu = false
                    }
                }) {
                    HStack {
                        Text(value)
                            .foregroundColor(localizationManager.currentLanguage == key ? .rosaFucsiaOscuro : .white)
                        Spacer()
                        if localizationManager.currentLanguage == key {
                            Image(systemName: "checkmark")
                                .foregroundColor(.rosaFucsiaOscuro)
                        }
                    }
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
                .background(Color.white.opacity(0.05))
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
        .transition(.move(edge: .leading))
        .cornerRadius(20)
        .shadow(color: .moradoMedio.opacity(0.2), radius: 10, x: 5, y: 0)
        .transition(.move(edge: .trailing))
    }
    
    private var mainMenu: some View {
        VStack(alignment: .leading, spacing: 25) {
            menuButton(icon: "brain.head.profile", text: "IA") {
                selectedTab = .ai
                showMenu = false
            }
            
            menuButton(icon: "shield", text: "Mantente Segura") {
                selectedTab = .security
                showMenu = false
            }
            
            menuButton(icon: "map", text: "Mapa") {
                selectedTab = .map
                showMenu = false
            }
            
            menuButton(icon: "star.fill", text: "Tu Evento") {
                goToTusIntereses = true
                showMenu = false
            }
            
            menuButton(icon: "heart.fill", text: "Salud") {
                goToSalud = true
                showMenu = false
            }
            
            menuButton(icon: "globe", text: "Idiomas") {
                showLanguageMenu = true
            }
            
            Spacer()
        }
        .padding()
        .transition(.move(edge: .leading))
        .cornerRadius(20)
        .shadow(color: .white.opacity(0.2), radius: 10, x: 5, y: 0)
        .transition(.move(edge: .leading))
    }
    
    private func menuButton(icon: String, text: String, action: @escaping () -> Void) -> some View {
        Button(action: { withAnimation { action() } }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                Text(text)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                if text == "Idiomas" {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
            }
            .padding(6)
            .background(Color.white.opacity(0.05))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}
