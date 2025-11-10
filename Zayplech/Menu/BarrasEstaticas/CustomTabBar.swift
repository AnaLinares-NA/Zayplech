//
//  CustomTabBar.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

// MARK: - Enum Tab (con icono y traducción)
enum Tab: String, CaseIterable {
    case home, translator, ai, security, map

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .translator: return "globe"
        case .ai: return "brain.head.profile"
        case .security: return "shield.lefthalf.fill"
        case .map: return "map.fill"
        }
    }

    // Eliminamos la propiedad title del enum
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    @EnvironmentObject var localizationManager: LocalizationManager
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 6) {
                        ZStack {
                            if selectedTab == tab {
                                Circle()
                                    .fill(Color.rosaFucsiaOscuro)
                                    .matchedGeometryEffect(id: "tab_circle", in: animationNamespace)
                                    .frame(width: 50, height: 50)
                                    .shadow(color: .rosaFucsiaOscuro.opacity(0.3), radius: 10, x: 0, y: 5)
                            }
                            Image(systemName: tab.icon)
                                .font(.system(size: 22))
                                .foregroundColor(selectedTab == tab ? .white : .rosaClaroFloral)
                        }
                        // Aquí usamos t() directamente, que ahora observa el environment
                        Text(tabTitle(for: tab))
                            .font(.caption2)
                            .foregroundColor(selectedTab == tab ? .rosaFucsiaOscuro : .rosaClaroFloral)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .background(
            ZStack {
                
                BlurView(style: .systemUltraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                LinearGradient(
                    colors: [Color.rosaChicle.opacity(0.9), Color.rosaMagenta.opacity(0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: selectedTab)
    }
    private func tabTitle(for tab: Tab) -> String {
        switch tab {
        case .home: return t("tab_home")
        case .translator: return t("tab_translator")
        case .ai: return t("tab_ai")
        case .security: return t("tab_security")
        case .map: return t("tab_map")
        }
    }
}

// MARK: - BlurView para fondo semi-transparente consistente
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Preview
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBar(selectedTab: .constant(.home))
        }
    }
}
