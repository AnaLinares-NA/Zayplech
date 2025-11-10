//
//  MainMenuView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    @AppStorage("selectedTab") private var selectedTab: Tab = .home
    @State private var showProfile = false
    @State private var goToProfile = false
    @State private var showMenu = false
    @State private var goToTusIntereses = false
    @State private var goToSalud = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    
                    NavigationLink(
                        destination: PerfilView(),
                        isActive: $goToProfile,
                        label: { EmptyView() }
                    )
                    .hidden()
                    
                    HeaderView(goToProfile: $goToProfile, showMenu: $showMenu)
                    
                    Spacer()
                    
                    Group {
                        switch selectedTab {
                        case .home: HomeView()
                        case .translator: TraduccionView()
                        case .ai: IAView()
                        case .security: SeguridadView()
                        case .map: MapView()
                        }
                    }
                    
                    CustomTabBar(selectedTab: $selectedTab)

                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden()
                
                if showMenu {
                    MenuView(
                        showMenu: $showMenu,
                        selectedTab: $selectedTab,
                        goToTusIntereses: $goToTusIntereses,
                        goToSalud: $goToSalud
                    )
                    .frame(width: 250)
                    
                    .shadow(radius: 5)
                    .transition(.move(edge: .leading))
                    .environmentObject(LocalizationManager.shared)
                }
            }
        }
    }
}


// MARK: - Feature Model
struct Feature: Identifiable {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let id = UUID()
    let key: String
    let icon: String
    let color: Color

    var title: String {
        t(key)
    }
}

let features: [Feature] = [
    Feature(key: "feature_security", icon: "shield.lefthalf.fill", color: .red),
    Feature(key: "feature_health", icon: "cross.case.fill", color: .green),
    Feature(key: "feature_language", icon: "globe", color: .blue),
    Feature(key: "feature_mobility", icon: "map.fill", color: .orange),
    Feature(key: "feature_economy", icon: "dollarsign.circle.fill", color: .purple),
    Feature(key: "feature_assistance", icon: "person.2.fill", color: .teal)
]

#Preview {
    MainMenuView()
            .environmentObject(LocalizationManager.shared)
            .environment(\.locale, Locale(identifier: "es"))
}
