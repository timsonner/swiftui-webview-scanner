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
    @Binding var html: String
    @Binding var statusCode: Int
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
            self.parent.statusCode = 0
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { html, error in
                if let html = html as? String {
                    DispatchQueue.main.async {
                        self.parent.html = html
                    }
                }
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if let httpResponse = (navigationResponse.response as? HTTPURLResponse) {
                DispatchQueue.main.async {
                    self.parent.statusCode = httpResponse.statusCode
                }
            } else {
                DispatchQueue.main.async {
                    self.parent.statusCode = 404
                }
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            let errorCode = (error as NSError).code
            if errorCode < 0 {
                DispatchQueue.main.async {
                    self.parent.statusCode = abs(errorCode)
                }
            }
        }
    }
}
