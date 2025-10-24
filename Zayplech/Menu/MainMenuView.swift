//
//  MainMenuView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

struct MainMenuView: View {
    @AppStorage("selectedTab") private var selectedTab: Tab = .home
    @State private var showProfile = false
    @State private var goToProfile = false

    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                    
                    NavigationLink(
                        destination: PerfilView(),
                        isActive: $goToProfile,
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
                    
                    HeaderView(goToProfile: $goToProfile)
                
                Spacer()

                // MARK: - Contenido principal según tab seleccionado
                switch selectedTab {
                case .home:
                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 25) {
                            
                            AlertCarousel()
                            
                            Text(t("mainmenu_que_necesitas"))
                                .font(.title3.bold())
                                .padding(.horizontal)
                            
                            FeaturesGrid()
                        }
                        .padding(.bottom, 80)
                    }
                    .background(Color.amarilloClaro.opacity(0.2))
                    
                case .translator:
                    Text(t("mainmenu_traductor_placeholder"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.amarilloClaro.opacity(0.1))
                    
                case .ai:
                    Text(t("mainmenu_ia_placeholder"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.lilaSuave.opacity(0.1))
                    
                case .security:
                    Text(t("mainmenu_seguridad_placeholder"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.rosaChicle.opacity(0.1))
                    
                case .map:
                    Text(t("mainmenu_mapa_placeholder"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.azulCielo.opacity(0.1))
                }
                
                // MARK: - TabBar
                CustomTabBar(selectedTab: $selectedTab)
                        .background(Color.blanco)
                        .shadow(radius: 5)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// MARK: - Feature Model
struct Feature: Identifiable {
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

// MARK: - FeatureCard
struct FeatureCard: View {
    let feature: Feature

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: feature.icon)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .padding()
                .background(feature.color)
                .clipShape(Circle())

            Text(feature.title)
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100, height: 120)
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(radius: 1)
    }
}

// MARK: - FeaturesGrid
struct FeaturesGrid: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(features) { feature in
                FeatureCard(feature: feature)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - AlertCard
struct AlertCard: View {
    var title: String
    var icon: String
    var color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .padding(10)
                .background(color)
                .clipShape(Circle())

            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(radius: 1)
        .frame(width: 300)
    }
}

// MARK: - AlertCarousel
struct AlertCarousel: View {
    let alerts = [
        (t("alert_sarampion"), "exclamationmark.triangle.fill", Color.red),
        (t("alert_metro"), "tram.fill", Color.orange),
        (t("alert_partido"), "calendar.badge.exclamationmark", Color.blue)
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(alerts, id: \.0) { alert in
                    AlertCard(title: alert.0, icon: alert.1, color: alert.2)
                }
            }
            .padding(.horizontal)
        }
    }
}



#Preview {
    MainMenuView()
            .environmentObject(LocalizationManager.shared)
            .environment(\.locale, Locale(identifier: "es"))
}
