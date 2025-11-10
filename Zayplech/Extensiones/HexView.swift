//
//  HexView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 20/10/25.
//

import SwiftUI

extension Color {
    static let naranjaMelocoton = Color(hex: "#F1A869")   // #F1A869
    static let amarilloClaro = Color(hex: "#F8FEC2")      // #F8FEC2
    static let azulCielo = Color(hex: "#5ACED2")          // #5ACED2
    static let lilaSuave = Color(hex: "#C785DA")          // #C785DA
    static let moradoMedio = Color(hex: "#9764D0")        // #9764D0
    static let rosaMagenta = Color(hex: "#CA61A0")        // #CA61A0
    static let rosaChicle = Color(hex: "#EC7599")         // #EC7599
    static let blanco = Color(hex: "#FFFFFF")             // blanco puro
    static let rappi = Color(hex: "FD6250")
    static let rosaFucsiaOscuro = Color(hex: "#B03060")   //fucsia oscuro elegante
    static let rosaClaroFloral = Color(hex: "#FFD9F5")   //fucsia oscuro elegante

}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}

