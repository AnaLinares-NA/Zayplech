//
//  PerfilView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI

struct PerfilView: View {
    @State private var showingRateSheet = false
    @State private var showingShareSheet = false
    @State private var showingLogoutSheet = false

    private let personalOptions = [
        ("info.circle.fill", "Sobre ti", AnyView(AboutYouView())),
        ("sportscourt.fill", "Sobre tus partidos", AnyView(YourMatchesView())),
        ("calendar", "Cambiar de evento", AnyView(ChangeEventView()))
    ]
    
    private let settingsOptions = [
        ("widget.small.badge.plus", "Widgets", AnyView(WidgetsView())),
        ("globe", "Cambiar idioma", AnyView(LanguageSelectionView2())),
        ("hand.raised.fill", "Permisos de acceso", AnyView(AccessPermissionsView())),
        ("bell.fill", "Notificaciones", AnyView(NotificationsView()))
    ]
    
    private let generalOptions: [(String, String, AnyView)] = [
        ("app.fill", "Sobre la app", AnyView(AboutAppView())),
        ("star.fill", "Valóranos", AnyView(EmptyView())), 
        ("square.and.arrow.up.fill", "Comparte la app", AnyView(EmptyView())),
        ("questionmark.circle.fill", "Ayuda", AnyView(HelpView())),
        ("power", "Cerrar sesión", AnyView(EmptyView()))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Información Personal
                    ProfileSection(
                        title: "INFORMACIÓN PERSONAL",
                        iconColor: .yellow,
                        headerView: AnyView(
                            VStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                                    .background(Color(.systemGray6))
                                    .clipShape(Circle())
                                    .padding(.bottom, 10)
                                
                                Text("Ana Linares")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .padding(.top, 15)
                        ),
                        options: personalOptions
                    )
                    
                    ProfileSection(title: "CONFIGURACIÓN", iconColor: .moradoMedio, options: settingsOptions)
                    
                    // MARK: - General con interceptación de "Valóranos"
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(0..<generalOptions.count, id: \.self) { i in
                            let option = generalOptions[i]
                            if option.1 == "Valóranos" {
                                Button(action: { showingRateSheet = true }) {
                                    row(icon: option.0, title: option.1, color: .blue)
                                }
                            } else if option.1 == "Comparte la app" {
                                Button(action: { showingShareSheet = true }) {
                                    row(icon: option.0, title: option.1, color: .blue)
                                }
                            } else if option.1 == "Cerrar sesión" {
                                Button(action: { showingLogoutSheet = true }) {
                                    row(icon: option.0, title: option.1, color: .red)
                                }
                            } else {
                                NavigationLink(destination: option.2) {
                                    row(icon: option.0, title: option.1, color: .blue)
                                }
                            }
                            
                            if i < generalOptions.count - 1 {
                                Divider().padding(.leading, 50)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // MARK: - Políticas
                    VStack(spacing: 0) {
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Text("POLÍTICA DE PRIVACIDAD")
                                .foregroundColor(.accentColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                        Divider()
                        NavigationLink(destination: TermsOfUseView()) {
                            Text("CONDICIONES DE USO")
                                .foregroundColor(.accentColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                .navigationTitle("Perfil")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color(.systemGroupedBackground))
        }
        .sheet(isPresented: $showingRateSheet) {
            RateSheet(showing: $showingRateSheet)
                .presentationDetents([.fraction(0.35)])
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareAppSheet(showing: $showingShareSheet)
                .presentationDetents([.fraction(0.4)])
        }
        .sheet(isPresented: $showingLogoutSheet) {
            LogoutSheet(showing: $showingLogoutSheet) {
                
                print("Sesión cerrada correctamente.")
            }
            .presentationDetents([.fraction(0.35)])
        }
    }
}

// MARK: - Sección genérica sin sombra
struct ProfileSection: View {
    let title: String
    let iconColor: Color
    var headerView: AnyView? = nil
    let options: [(String, String, AnyView)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let header = headerView {
                header.frame(maxWidth: .infinity)
            }
            if !options.isEmpty {
                ForEach(0..<options.count, id: \.self) { i in
                    let option = options[i]
                    NavigationLink(destination: option.2) {
                        HStack {
                            Image(systemName: option.0).foregroundColor(iconColor)
                            Text(option.1).foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right").foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                    }
                    if i < options.count - 1 {
                        Divider().padding(.leading, 50)
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

// MARK: - Sheet reducido y elegante
struct RateSheet: View {
    @Binding var showing: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            Text("¿Te gusta usar Zayplech?")
                .font(.headline)
            
            Text("Déjanos tu valoración en la App Store")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button {
                if let url = URL(string: "https://apps.apple.com/app/idXXXXXXXXX") {
                    UIApplication.shared.open(url)
                }
                showing = false
            } label: {
                Label("Valorar en App Store", systemImage: "star.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [.rosaChicle, .moradoMedio],
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding(.bottom, 20)
        .background(Color(.systemBackground))
        .presentationCornerRadius(25)
    }
}

// MARK: - Sheet de Compartir la App
struct ShareAppSheet: View {
    @Binding var showing: Bool
    private let shareLink = "https://www.appstore.com/myapp/?id=SXH41H41A1DZXA"
    
    func copyToClipboard() {
        UIPasteboard.general.string = shareLink
        
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            Text("Comparte Zayplech")
                .font(.headline)
            
            Text("Invita a tus amigas a usar la app del Mundial 🤍🌸")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Text(shareLink)
                    .font(.footnote)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button(action: copyToClipboard) {
                    Image(systemName: "doc.on.doc.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.moradoMedio)
                        .clipShape(Circle())
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            HStack(spacing: 30) {
                ShareAppOption(icon: "message.fill", color: .blue, name: "Mensajes")
                ShareAppOption(icon: "airplay.audio", color: .black, name: "Airdrop")
                ShareAppOption(icon: "envelope.fill", color: .orange, name: "Correo")
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.bottom, 20)
        .background(Color(.systemBackground))
        .presentationCornerRadius(25)
    }
}

// MARK: - Botones de apps sociales
struct ShareAppOption: View {
    let icon: String
    let color: Color
    let name: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
                .padding(15)
                .background(color)
                .clipShape(Circle())
            
            Text(name)
                .font(.caption2)
                .foregroundColor(.primary)
        }
        .onTapGesture {
            print("Compartir en \(name)")
        }
    }
}

// MARK: - Sheet de Confirmación de Cierre de Sesión
struct LogoutSheet: View {
    @Binding var showing: Bool
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            Text("¿Cerrar sesión?")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Perderás el acceso temporal a tu cuenta hasta que vuelvas a iniciar sesión.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            HStack(spacing: 15) {
                Button(action: {
                    showing = false
                }) {
                    Text("Cancelar")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                
                Button(action: {
                    onConfirm()
                    showing = false
                }) {
                    Text("Cerrar sesión")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(colors: [.rosaChicle, .moradoMedio],
                                                   startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
            Spacer()
        }
        .padding(.bottom, 20)
        .background(Color(.systemBackground))
        .presentationCornerRadius(25)
    }
}

@ViewBuilder
private func row(icon: String, title: String, color: Color) -> some View {
    HStack {
        Image(systemName: icon).foregroundColor(color)
        Text(title).foregroundColor(.primary)
        Spacer()
        Image(systemName: "chevron.right").foregroundColor(.gray)
    }
    .padding()
    .background(Color.white)
}

#Preview {
    PerfilView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
