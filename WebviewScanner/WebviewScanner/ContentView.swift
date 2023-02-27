//
//  ContentView.swift
//  WebviewScanner
//
//  Created by Tim Sonner on 2/26/23.
//

import SwiftUI

struct ContentView: View {
    @State var statusCode: Int?

    var body: some View {
        VStack {
            if let statusCode = statusCode {
                Text("Status Code: \(statusCode)")
            } else {
                Text("Loading...")
            }
            WebView(url: URL(string: "https://www.example.com")!, statusCode: $statusCode)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
