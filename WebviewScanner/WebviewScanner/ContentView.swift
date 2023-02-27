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
    @State var statusCode: Int = 0
    @State var html: String = ""
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                TextField("Enter URL", text: $urlString, onCommit: {
                    self.statusCode = 0
                    self.html = ""
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
                
                WebView(url: URL(string: urlString)!, html: $html, statusCode: $statusCode)
            }
            .tag(0)
            .navigationBarTitle("Site")
            .tabItem {
                Image(systemName: "globe")
                Text("Site")
            }
            
            ScrollView {
                Text(html)
                    .padding()
            }
            .tag(1)
            .navigationBarTitle("HTML")
            .tabItem {
                Image(systemName: "doc.text")
                Text("HTML")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
