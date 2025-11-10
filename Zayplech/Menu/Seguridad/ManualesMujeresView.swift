//
//  ManualesMujeresView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct ManualItem: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    let icon: String
}

struct ManualItemViewData: Identifiable {
    let id = UUID()
    let manual: ManualContent
    let color: Color
    let icon: String
}

struct ManualesMujeresView: View {
    
    let manualItems: [ManualItemViewData] = [
        ManualItemViewData(manual: assaultContent, color: .green, icon: "shield.fill"),
        ManualItemViewData(manual: reportContent, color: .red, icon: "doc.text.fill"),
        ManualItemViewData(manual: extortionContent, color: .blue, icon: "exclamationmark.triangle.fill"),
        ManualItemViewData(manual: earthquakeContent, color: .orange, icon: "shareplay"),
        ManualItemViewData(manual: fireContent, color: .purple, icon: "flame.fill"),
        ManualItemViewData(manual: publicTransportContent, color: .pink, icon: "car.fill"),
        ManualItemViewData(manual: crowdsContent, color: .teal, icon: "person.3.fill"),
        ManualItemViewData(manual: alertEnvironmentContent, color: .yellow, icon: "eye.fill"),
            ManualItemViewData(manual: harassmentProtocolContent, color: .mint, icon: "shield.fill"),
            ManualItemViewData(manual: redFlagsContent, color: .indigo, icon: "exclamationmark.triangle.fill"),
            ManualItemViewData(manual: transportDatingTipsContent, color: .cyan, icon: "car.fill"),
            ManualItemViewData(manual: supportNetworkContent, color: .brown, icon: "person.3.fill")
        ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Manuales para mujeres")
                        .font(.title.bold())
                        .padding(.horizontal)
                        .padding(.top, 16)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(manualItems) { item in
                            NavigationLink(destination: ManualDetailView(content: item.manual)) {
                                ManualCard(title: item.manual.title, color: item.color, icon: item.icon)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.bottom, 50)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ManualesMujeresView()
}
