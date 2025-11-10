//
//  Hospital.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI
import MapKit

struct Hospital: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var isSelected: Bool
}

struct HospitalSheetView: View {
    @Binding var hospitals: [Hospital]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "cross.case.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                Text("Hospitales")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 5)
            
            ScrollView {
                ForEach(hospitals.indices, id: \.self) { index in
                    HStack {
                        Text(hospitals[index].name)
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                hospitals[index].isSelected.toggle()
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(hospitals[index].isSelected ? Color.blue.opacity(0.15) : Color.gray.opacity(0.15))
                                    .frame(width: 34, height: 34)
                                
                                Image(systemName: hospitals[index].isSelected ? "cross.circle.fill" : "cross.circle")
                                    .font(.system(size: 22))
                                    .foregroundColor(hospitals[index].isSelected ? .blue : .gray)
                                    .scaleEffect(hospitals[index].isSelected ? 1.15 : 1.0)
                                    .shadow(color: hospitals[index].isSelected ? .blue.opacity(0.3) : .clear, radius: 5)
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
