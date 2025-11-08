//
//  HeaderView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

struct HeaderView: View {
    @Binding var goToProfile: Bool
    @Binding var showMenu: Bool
    @EnvironmentObject var localizationManager: LocalizationManager

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Barra superior
            HStack {
                Button(action: {
                    withAnimation {
                        showMenu.toggle()
                    }
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
            .zIndex(1)

            // Menú deslizable
            if showMenu {
                // Fondo para cerrar el menú tocando fuera
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showMenu = false
                        }
                    }
                    .zIndex(2)
                
                // Llamada a tu menú personalizado
                MenuView(showMenu: $showMenu)
                    .frame(width: 250)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .offset(x: 16, y: 60)
                    .transition(.move(edge: .leading))
                    .zIndex(3)
            }
        }
    }
}


#Preview {
    HeaderView(goToProfile: .constant(false), showMenu: .constant(false))
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
