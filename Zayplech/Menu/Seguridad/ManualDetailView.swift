//
//  ManualDetailView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct ManualDetailView: View {
    let content: ManualContent  // <-- Cambiamos AidContent por ManualContent
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(content.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.rosaMagenta)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(content.steps) { step in
                        VStack(spacing: 10) {
                            Image(systemName: step.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.rosaMagenta)
                            
                            Text(step.description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.purple.opacity(0.1))
                        )

                    }
                }
                .padding()
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct StepManualView: View {
    let step: ManualStep  // <-- Cambiamos AidStep por ManualStep

    var body: some View {
        VStack(spacing: 10) {
            Text(step.description)  // Para ManualStep solo tenemos description
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.purple.opacity(0.1))
        )
    }
}
