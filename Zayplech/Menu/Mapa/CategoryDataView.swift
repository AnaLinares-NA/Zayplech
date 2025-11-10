//
//  CategoryDataView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI
import MapKit

struct LocationItem: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    var isSelected: Bool = false
}

struct CategorySheetView: View {
    @Binding var items: [LocationItem]
    let title: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(imageName)
                    .font(.title2)
                    .foregroundColor(.orange)
                Text(title)
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 5)
            
            ScrollView {
                ForEach($items) { $item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Toggle("", isOn: $item.isSelected)
                            .labelsHidden()
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 5))
        .padding(.horizontal)
    }
}

struct StadiumsData {
    static let stadiums: [Stadium] = [
        Stadium(name: "Estadio Azteca", coordinate: CLLocationCoordinate2D(latitude: 19.3029794, longitude: -99.1504699525862), isSelected: false),
        Stadium(name: "Estadio AKRON", coordinate: CLLocationCoordinate2D(latitude: 20.682072, longitude: -103.462471391614), isSelected: false),
        Stadium(name: "Estadio BBVA", coordinate: CLLocationCoordinate2D(latitude: 25.66921455, longitude: -100.245235863835), isSelected: false),
        Stadium(name: "Mercedes-Benz Stadium", coordinate: CLLocationCoordinate2D(latitude: 33.755489, longitude: -84.401993), isSelected: false),
        Stadium(name: "Los Angeles Stadium", coordinate: CLLocationCoordinate2D(latitude: 34.161327, longitude: -118.167648), isSelected: false),
        Stadium(name: "Kansas City Stadium", coordinate: CLLocationCoordinate2D(latitude: 39.048786, longitude: -94.484566), isSelected: false),
        Stadium(name: "BMO Field-Toronto Stadium", coordinate: CLLocationCoordinate2D(latitude: 43.626331, longitude: -79.417830), isSelected: false),
        Stadium(name: "BC Place Vancouver", coordinate: CLLocationCoordinate2D(latitude: 49.276684, longitude: -123.112404), isSelected: false)
    ]
}


/* En el futuro se añadiran más categorías aquí:
struct RestaurantsData { ... }
struct HospitalsData { ... }
*/

