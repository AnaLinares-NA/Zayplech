//
//  PerfilView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

// MARK: - ProfileView
struct PerfilView: View {
    var body: some View {
        VStack {
            Text("👤 Perfil de usuario")
                .font(.title)
                .padding()
            Spacer()
        }
        .navigationTitle(t("profile_title"))
        .background(Color.amarilloClaro.opacity(0.1))
    }
}


#Preview {
    PerfilView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
