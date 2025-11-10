//
//  AboutAppView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct AboutAppView: View {

    private let appCreatorsMessage = """
    ¡Encantadas de conocerte, USUARIO!
    Somos Ann, Noemi, Anita y Majo, cuatro estudiantes mexicanas que estamos detrás de esta aplicación, claro que logramos estar en tu celular gracias a diversos apoyos tales como Xcode, Swift, FIREBASE, CoreData y mucho mas...

    Comenzamos este proyecto desde el 2025 y esperamos lanzarlo para antes del mundial 2026, asi como mantenerlo despues de él 🤍🌸.

    Creamos esta aplicación buscando brindar seguridad a los asistentes de los eventos más masivos, especialmente mujeres, ya que sabemos los riesgos que llegamos a correr en situaciones como estas...
    ¡Esperemos que estés disfrutando de tu evento!
    """

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Mascota y Mensaje
                VStack(alignment: .leading, spacing: 15) {
                    
                    Image("Zayplech_Mascota1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                    
                    Text(appCreatorsMessage)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Text("Ann, Noemi, Anita y Majo")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    AboutAppView()
}
