//
//  HospitalsData.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 09/11/25.
//


//
//  HospitalsData.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import Foundation
import MapKit

struct HospitalsData {
    static let hospitals: [Hospital] = [
        Hospital(name: "Hospital Ángeles Pedregal", coordinate: CLLocationCoordinate2D(latitude: 19.325774, longitude: -99.214344), isSelected: false),
        Hospital(name: "Hospital ABC Santa Fe", coordinate: CLLocationCoordinate2D(latitude: 19.361906, longitude: -99.275099), isSelected: false)
    ]
}
