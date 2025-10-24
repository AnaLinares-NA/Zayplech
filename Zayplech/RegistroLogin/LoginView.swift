//
//  LoginView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    @State private var isEmailSelected = true
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var navigateToMainMenu = false
    @State private var showPasswordError = false
    @State private var showRegistro = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Spacer(minLength: 20)
                
                Text(t("login_titulo"))
                    .font(.title2)
                    .bold()
                
                HStack(spacing: 0) {
                    Button(action: {
                        isEmailSelected = false
                    }) {
                        Text(t("registro_phone"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(!isEmailSelected ? Color.naranjaMelocoton : Color.clear)
                            .cornerRadius(8)
                    }
                    .foregroundColor(!isEmailSelected ? .white : .gray)
                    
                    Button(action: {
                        isEmailSelected = true
                    }) {
                        Text(t("registro_email"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(isEmailSelected ? Color.naranjaMelocoton : Color.clear)
                            .cornerRadius(8)
                    }
                    .foregroundColor(isEmailSelected ? .white : .gray)
                }
                .padding(.horizontal, 30)
                .animation(.easeInOut, value: isEmailSelected)
                
                VStack(spacing: 15) {
                    if isEmailSelected {
                        StyledTextField(
                            placeholder: t("registro_email_placeholder"),
                            text: $email,
                            icon: "envelope.fill",
                            keyboardType: .emailAddress
                        )
                    } else {
                        StyledTextField(
                            placeholder: t("registro_phone_placeholder"),
                            text: $phone,
                            icon: "phone.fill",
                            keyboardType: .phonePad
                        )
                    }
                    
                    StyledSecureField(
                        placeholder: t("registro_password"),
                        text: $password
                    )
                    
                    if showPasswordError {
                        Text(t("login_error"))
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Toggle(isOn: $rememberMe) {
                        Text(t("login_recordar_usuario"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .naranjaMelocoton))
                    .padding(.top, 5)
                    
                    Button(action: {
                        print("Recuperar contraseña")
                    }) {
                        Text(t("login_olvidaste_contrasena"))
                            .font(.footnote)
                            .foregroundColor(.moradoMedio)
                            .underline()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    if password.isEmpty {
                        showPasswordError = true
                    } else {
                        showPasswordError = false
                        navigateToMainMenu = true
                    }
                }) {
                    Text(t("login_boton"))
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.naranjaMelocoton)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .padding(.horizontal, 30)
                        .shadow(radius: 3)
                }
                .padding(.top, 10)
                
                VStack(spacing: 5) {
                    Text(t("login_eres_nuevo"))
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                    Button(action: {
                        showRegistro = true
                    }) {
                        Text(t("registro_titulo"))
                            .underline()
                            .font(.subheadline)
                            .foregroundColor(.moradoMedio)
                    }
                    
                }
                .padding(.top, 5)
                
                VStack(spacing: 10) {
                    Text(t("registro_social"))
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                    HStack(spacing: 20) {
                        SocialButton(image: "G", color: .red)
                        SocialButton(image: "f", color: .blue)
                        SocialButton(image: "applelogo", color: .black)
                        SocialButton(image: "x", color: .black)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                NavigationLink(destination: RegistroView(), isActive: $showRegistro) {
                    EmptyView()
                }
            }
            .padding(.vertical)
            .background(Color.blanco.ignoresSafeArea())
            
            .navigationDestination(isPresented: $navigateToMainMenu) {
                MainMenuView()
            }
            .navigationBarBackButtonHidden()
        }
    }
}


#Preview {
    LoginView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
        .previewDisplayName("Español")
}
