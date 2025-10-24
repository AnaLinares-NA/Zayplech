//
//  URLView.swift
//  JuntosMX
//
//  Created by Ana Linares Guzmán on 30/07/25.
//

import SwiftUI
import WebKit

struct URLView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
