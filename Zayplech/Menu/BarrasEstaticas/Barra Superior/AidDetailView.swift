//
//  AidDetailView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct AidDetailView: View {
    let content: AidContent
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(content.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(content.steps) { step in
                        StepView(step: step)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct StepView: View {
    let step: AidStep
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Paso \(step.number)")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundColor(.orange)
            
            Image(systemName: step.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity)
            
            Text(step.description)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.orange.opacity(0.1))
        )
    }
}

