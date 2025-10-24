//
//  CustomTabBar.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

// MARK: - Enum Tab (con icono y traducción)
enum Tab: String, CaseIterable {
    case home
    case translator
    case ai
    case security
    case map

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .translator: return "globe"
        case .ai: return "brain.head.profile"
        case .security: return "shield.lefthalf.fill"
        case .map: return "map.fill"
        }
    }

    var title: String {
        switch self {
        case .home: return t("tab_home")
        case .translator: return t("tab_translator")
        case .ai: return t("tab_ai")
        case .security: return t("tab_security")
        case .map: return t("tab_map")
        }
    }
}


struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        selectedTab = tab
                    }
                }) {
                    VStack {
                        if selectedTab == tab {
                            Circle()
                                .fill(Color.naranjaMelocoton.opacity(0.2))
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: tab.icon)
                                        .font(.system(size: 22))
                                        .foregroundColor(.naranjaMelocoton)
                                )
                        } else {
                            Image(systemName: tab.icon)
                                .font(.system(size: 22))
                                .foregroundColor(.gray)
                        }

                        Text(tab.title)
                            .font(.caption2)
                            .foregroundColor(selectedTab == tab ? .naranjaMelocoton : .gray)
                    }
                }
                Spacer()
            }
        }
        .frame(height: 70)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal, 10)
        .padding(.bottom, 5)
    }
}


#Preview {
    CustomTabBar(selectedTab: .constant(.home))
        .background(Color.white)
        .previewLayout(.sizeThatFits)
        .environmentObject(LocalizationManager.shared)
}
