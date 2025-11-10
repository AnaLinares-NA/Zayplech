//
//  SplashView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                LanguageSelectionView()
            } else {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image("Zayplech_Mascota1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    Text("ZAYPLECH")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(Color.naranjaMelocoton)
                    
                    Text("Conectando con la experiencia del Mundial…")
                        .font(.headline)
                        .foregroundColor(Color.naranjaMelocoton)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blanco)
                .ignoresSafeArea()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
        .previewDisplayName("Español")
}
