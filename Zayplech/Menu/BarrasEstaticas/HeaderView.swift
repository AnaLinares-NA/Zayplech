//
//  HeaderView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

struct HeaderView: View {
    @Binding var goToProfile: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                // Acción para el menú lateral (puedes implementar drawer después)
            }) {
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
                    .foregroundColor(.naranjaMelocoton)
            }
            
            Spacer()
            
            Text(t("mainmenu_title"))
                .font(.headline)
                .foregroundColor(.naranjaMelocoton)
            
            Spacer()
            
            Button(action: {
                goToProfile = true
            }) {
                Image(systemName: "person.crop.circle")
                    .font(.title2)
                    .foregroundColor(.naranjaMelocoton)
            }
        }
        .padding()
        .background(Color.blanco)
        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    HeaderView(goToProfile: .constant(false))
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
