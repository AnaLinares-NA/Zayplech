//
//  TuEquipoView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct TuEquipoView: View {
    
    var body: some View {
        VStack(spacing: 30) {

            VStack(alignment: .leading, spacing: 10) {
                Text("""
Podrás conocer las **alineaciones** y la **plantilla completa** de tu equipo tan pronto como sean publicadas por la fuente oficial. Estaremos **actualizando los datos en tiempo real**.
""")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.rosaChicle.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.rosaChicle.opacity(0.8), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 30)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    TuEquipoView()
}
