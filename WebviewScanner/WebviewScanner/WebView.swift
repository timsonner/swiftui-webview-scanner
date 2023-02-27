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

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator // set the coordinator as the navigation delegate
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Coordinator that adopts WKNavigationDelegate
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // Called when the web view receives a response for the navigation request
        func webView(_ webView: WKWebView, didReceive response: URLResponse) {
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                // Update the parent view with the status code
                DispatchQueue.main.async {
                    // Use @Binding or other means to update the status code in the parent view
                    // parent.statusCode = httpResponse.statusCode
                }
            }
        }
    }
}

