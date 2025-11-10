//
//  EventoSelectionView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

struct Evento: Identifiable {
    let id = UUID()
    let titleKey: String
    let iconName: String
}

struct EventoSelectionView: View {
    @State private var showDeportesList = false
    @State private var navigateToOnboarding = false
    @EnvironmentObject var localizationManager: LocalizationManager

    private let eventos: [Evento] = [
        Evento(titleKey: "evento_deportes", iconName: "sportscourt"),
        Evento(titleKey: "evento_conciertos", iconName: "music.note"),
        Evento(titleKey: "evento_desfiles", iconName: "figure.walk"),
        Evento(titleKey: "evento_ferias", iconName: "tent"),
        Evento(titleKey: "evento_congresos", iconName: "person.3.sequence"),
        Evento(titleKey: "evento_meet_greet", iconName: "hand.raised")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()

                Text(t("evento_titulo"))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 20)]) {
                        ForEach(eventos) { evento in
                            Button(action: {
                                if evento.titleKey == "evento_deportes" {
                                    showDeportesList = true
                                }
                            }) {
                                VStack(spacing: 10) {
                                    Image(systemName: evento.iconName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.lilaSuave)

                                    Text(t(evento.titleKey))
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity, minHeight: 120)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(14)
                                .shadow(radius: 3)
                            }
                            .disabled(evento.titleKey != "evento_deportes")
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .background(Color(.systemGroupedBackground))
            .sheet(isPresented: $showDeportesList) {
                VStack(spacing: 20) {
                    Text(t("evento_deportes_titulo"))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)

                    List {
                        Button(action: {
                            showDeportesList = false
                            navigateToOnboarding = true
                        }) {
                            Text(t("evento_deportes_mundial"))
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                    }
                    .listStyle(.insetGrouped)

                    Spacer()
                }
                .presentationDetents([.medium])
            }
            .navigationDestination(isPresented: $navigateToOnboarding) {
                ContentView()
                    .environmentObject(localizationManager)
            }
        }
    }
}

#Preview {
    EventoSelectionView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
        .previewDisplayName("Español")
}
