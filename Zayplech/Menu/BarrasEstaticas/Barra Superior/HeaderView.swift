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
        ZStack {
            
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

            HStack {
                Button(action: {
                    withAnimation {
                        showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text(t("mainmenu_title"))
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    goToProfile = true
                }) {
                    Image(systemName: "person.crop.circle")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 60)
        .padding(.horizontal, 12)
        .padding(.top, 10)
    }
}

// MARK: - Preview
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeaderView(goToProfile: .constant(false), showMenu: .constant(false))
            Spacer()
        }
        .environmentObject(LocalizationManager.shared)
    }
}
