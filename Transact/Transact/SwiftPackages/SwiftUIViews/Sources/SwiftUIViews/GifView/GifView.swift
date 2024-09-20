//
//  GifView.swift
//
//
//  Created by Ahmed Yamany on 12/05/2024.
//

import SwiftUI
import WebKit

public struct GifView: UIViewRepresentable {
    private var url: URL?
    private var request: URLRequest?
    
    public init(_ url: URL) {
        self.url = url
    }
    
    public init(request: URLRequest) {
        self.request = request
    }
   
    public func makeUIView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        
        if let url, let data = try? Data(contentsOf: url) {
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url.deletingLastPathComponent()
            )
        }
        
        if let request {
            webView.load(request)
        }
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.reload()
    }
}
