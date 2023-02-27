//
//  WebView.swift
//  WebviewScanner
//
//  Created by Tim Sonner on 2/26/23.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var statusCode: Int?

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.statusCode = webView.url != nil ? 200 : nil
            }
        }
    }
}
