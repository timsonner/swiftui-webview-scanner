//
//  ContentView.swift
//  WebviewScanner
//
//  Created by Tim Sonner on 2/26/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State var urlString: String = "https://www.apple.com"
    @State var statusCode: Int? = nil
    
    var body: some View {
        VStack {
            TextField("Enter URL", text: $urlString, onCommit: {
                self.statusCode = nil
            })
            .textFieldStyle(.roundedBorder)
            .padding()
            
            Divider()
            
            if let statusCode = statusCode {
                Text("Status Code: \(statusCode)")
                    .font(.headline)
            } else {
                Text("Loading...")
                    .font(.headline)
            }
            
            WebView(urlString: urlString, statusCode: $statusCode)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
