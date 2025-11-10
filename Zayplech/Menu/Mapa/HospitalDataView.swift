//
//  HospitalsData.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import Foundation
import MapKit

struct HospitalDataView {
    static let hospitals: [Hospital] = [
        Hospital(
            name: "Hospital Ángeles Lomas",
            coordinate: CLLocationCoordinate2D(latitude: 19.437750284749995, longitude: -99.21623915400971),
            isSelected: false
        ),
        Hospital(
            name: "Hospital ABC Observatorio",
            coordinate: CLLocationCoordinate2D(latitude: 19.440057019800182, longitude: -99.21842783661052),
            isSelected: false
        )
    ]
}
