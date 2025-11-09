//
//  Refugio.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 09/11/25.
//


//
//  RefugiosSheetView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI
import MapKit

struct Refugio: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var isSelected: Bool
}

struct RefugiosSheetView: View {
    @Binding var refugios: [Refugio]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "house.fill")
                    .font(.title2)
                    .foregroundColor(.green)
                Text("Refugios")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 5)
            
            ScrollView {
                ForEach(refugios.indices, id: \.self) { index in
                    HStack {
                        Text(refugios[index].name)
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                refugios[index].isSelected.toggle()
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(refugios[index].isSelected ? Color.green.opacity(0.15) : Color.gray.opacity(0.15))
                                    .frame(width: 34, height: 34)
                                
                                Image(systemName: refugios[index].isSelected ? "house.circle.fill" : "house.circle")
                                    .font(.system(size: 22))
                                    .foregroundColor(refugios[index].isSelected ? .green : .gray)
                                    .scaleEffect(refugios[index].isSelected ? 1.15 : 1.0)
                                    .shadow(color: refugios[index].isSelected ? .green.opacity(0.3) : .clear, radius: 5)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 4)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
        .frame(maxHeight: 300)
    }
}
