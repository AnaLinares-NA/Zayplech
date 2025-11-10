//
//  ContentView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI



struct OnboardingSlide: Identifiable {
    let id = UUID()
    let imageName: String
    let titleKey: String
    let descriptionKey: String
}

struct ContentView: View {
    @State private var currentIndex = 0
    @State private var showRegistro = false
    @EnvironmentObject var localizationManager: LocalizationManager

    private let slides: [OnboardingSlide] = [
        OnboardingSlide(imageName: "shield.lefthalf.filled", titleKey: "onboarding_1_title", descriptionKey: "onboarding_1_desc"),
        OnboardingSlide(imageName: "heart.text.square", titleKey: "onboarding_2_title", descriptionKey: "onboarding_2_desc"),
        OnboardingSlide(imageName: "globe", titleKey: "onboarding_3_title", descriptionKey: "onboarding_3_desc"),
        OnboardingSlide(imageName: "map.fill", titleKey: "onboarding_4_title", descriptionKey: "onboarding_4_desc"),
        OnboardingSlide(imageName: "dollarsign.circle.fill", titleKey: "onboarding_5_title", descriptionKey: "onboarding_5_desc"),
        OnboardingSlide(imageName: "sportscourt.fill", titleKey: "onboarding_6_title", descriptionKey: "onboarding_6_desc")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.blanco.ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showRegistro = true
                        }) {
                            Text(t("skip_button"))
                                .foregroundColor(.naranjaMelocoton)
                                .bold()
                        }
                        .padding()
                    }

                    TabView(selection: $currentIndex) {
                        ForEach(slides.indices, id: \.self) { index in
                            VStack(spacing: 30) {

                                Image(systemName: slides[index].imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 180, height: 180)
                                    .foregroundColor(Color.azulCielo)
                                    .transition(.scale)
                                    .padding()
                                
                                Text(t(slides[index].titleKey))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                
                                Text(t(slides[index].descriptionKey))
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                                
                                Spacer()
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .animation(.easeInOut, value: currentIndex)
                    
                    Button(action: {
                        if currentIndex < slides.count - 1 {
                            currentIndex += 1
                        } else {
                            showRegistro = true
                        }
                    }) {
                        Text(t(currentIndex == slides.count - 1 ? "start_button" : "next_button"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.azulCielo)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .padding(.horizontal, 30)
                            .shadow(radius: 3)
                    }
                    .padding(.bottom, 30)
                    
                    NavigationLink(destination: RegistroView(), isActive: $showRegistro) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
        .previewDisplayName("Español")
}



