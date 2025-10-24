//
//  RegistroView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

struct RegistroView: View {
    @EnvironmentObject var localizationManager: LocalizationManager

    @State private var isEmailSelected = true
    @State private var email = ""
    @State private var phone = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPasswordMismatch = false
    @State private var navigateToMainMenu = false
    @State private var showLogin = false

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Spacer(minLength: 10)
                
                Text(t("registro_titulo"))
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
                        StyledTextField(placeholder: t("registro_email_placeholder"), text: $email, icon: "envelope.fill", keyboardType: .emailAddress)
                    } else {
                        StyledTextField(placeholder: t("registro_phone_placeholder"), text: $phone, icon: "phone.fill", keyboardType: .phonePad)
                    }
                    
                    StyledTextField(placeholder: t("registro_first_name"), text: $firstName, icon: "person.fill")
                    
                    StyledTextField(placeholder: t("registro_last_name"), text: $lastName, icon: "person.fill")
                    
                    StyledSecureField(placeholder: t("registro_password"), text: $password)
                    
                    StyledSecureField(placeholder: t("registro_confirmar_password"), text: $confirmPassword)
                    
                    if showPasswordMismatch {
                        Text(t("registro_error_confirmacion"))
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    // Indicadores de validación del password
                    HStack {
                        PasswordRequirementView(isMet: password.count >= 8, text: t("registro_pass_min"))
                        Spacer()
                        PasswordRequirementView(isMet: password.contains(where: { $0.isUppercase }), text: t("registro_pass_upper"))
                        Spacer()
                        PasswordRequirementView(isMet: password.contains(where: { $0.isNumber }), text: t("registro_pass_num"))
                    }
                    .padding(.horizontal, 4)
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    if password == confirmPassword {
                        showPasswordMismatch = false
                        navigateToMainMenu = true
                    } else {
                        showPasswordMismatch = true
                    }
                }) {
                    Text(t("registro_next"))
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
                    Text(t("registro_tienes_cuenta"))
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                    Button(action: {
                        showLogin = true
                    }) {
                        Text(t("registro_ir_login"))
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
            }
            .padding(.vertical)
            .background(Color.blanco.ignoresSafeArea())
            NavigationLink(destination: LoginView(), isActive: $showLogin) {
                EmptyView()
            }
            .navigationDestination(isPresented: $navigateToMainMenu) {
                MainMenuView()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct PasswordRequirementView: View {
    let isMet: Bool
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(isMet ? .green : .gray)
            .animation(.easeInOut, value: isMet)
    }
}

struct SocialButton: View {
    let image: String
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.moradoMedio, lineWidth: 1)
                .frame(width: 50, height: 50)
            if image == "applelogo" {
                Image(systemName: image)
                    .foregroundColor(color)
                    .font(.system(size: 20))
            } else {
                Text(image)
                    .font(.title2)
                    .bold()
                    .foregroundColor(color)
            }
        }
    }
}

struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String
    var icon: String? = nil
    var keyboardType: UIKeyboardType = .default
    
    @FocusState private var isFocused: Bool
    @State private var animate: Bool = false
    
    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.azulCielo)
                    .opacity(animate ? 0.3 : 1.0)
                    .animation(
                        isFocused
                            ? .easeInOut(duration: 0.6).repeatForever(autoreverses: true)
                            : .default,
                        value: animate
                    )
            }
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .focused($isFocused)
                .onChange(of: isFocused) { newValue in
                    if newValue {
                        animate = true
                    } else {
                        animate = false
                    }
                }
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.azulCielo, lineWidth: 1)
        )
        .cornerRadius(10)
    }
}

struct StyledSecureField: View {
    let placeholder: String
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    @State private var animate: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .foregroundColor(.azulCielo)
                .opacity(animate ? 0.3 : 1.0)
                .animation(
                    isFocused
                        ? .easeInOut(duration: 0.6).repeatForever(autoreverses: true)
                        : .default,
                    value: animate
                )
            SecureField(placeholder, text: $text)
                .focused($isFocused)
                .onChange(of: isFocused) { newValue in
                    if newValue {
                        animate = true
                    } else {
                        animate = false
                    }
                }
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.azulCielo, lineWidth: 1)
        )
        .cornerRadius(10)
    }
}



#Preview {
    RegistroView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
        .previewDisplayName("Español")
}

