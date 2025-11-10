//
//  StadiumsSheetView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI
import MapKit

struct Stadium: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var isSelected: Bool
}

struct StadiumsSheetView: View {
    @Binding var stadiums: [Stadium]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "sportscourt")
                    .font(.title2)
                    .foregroundColor(.orange)
                Text("Estadios")
                    .font(.headline)
                Spacer()
                
            }
            .padding(.bottom, 5)
            
            ScrollView {
                ForEach(stadiums.indices, id: \.self) { index in
                    HStack {
                        Text(stadiums[index].name)
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                stadiums[index].isSelected.toggle()
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(stadiums[index].isSelected ? Color.red.opacity(0.15) : Color.gray.opacity(0.15))
                                    .frame(width: 34, height: 34)
                                
                                Image(systemName: stadiums[index].isSelected ? "mappin.circle.fill" : "mappin.circle")
                                    .font(.system(size: 22))
                                    .foregroundColor(stadiums[index].isSelected ? .red : .gray)
                                    .scaleEffect(stadiums[index].isSelected ? 1.15 : 1.0)
                                    .shadow(color: stadiums[index].isSelected ? .red.opacity(0.3) : .clear, radius: 5)
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
