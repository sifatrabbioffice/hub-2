import SwiftUI
import WebKit
import GameController

@main
struct GameHubApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var isPlaying = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if isPlaying {
                // The actual playable engine
                GameStreamView(url: URL(string: "https://www.xbox.com/play")!) // Example Cloud Endpoint
                    .ignoresSafeArea()
                
                // Virtual Overlay Toggle
                VStack {
                    HStack {
                        Button("EXIT") { isPlaying = false }
                            .padding().background(Color.red).cornerRadius(10)
                        Spacer()
                    }
                    Spacer()
                }.padding()
            } else {
                // Menu UI
                VStack(spacing: 20) {
                    Text("GAMEHUB PRO")
                        .font(.system(size: 40, weight: .black))
                        .foregroundColor(.blue)
                    
                    Button(action: { isPlaying = true }) {
                        Text("LAUNCH CLOUD ENGINE")
                            .bold()
                            .padding()
                            .frame(width: 280)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    Text("Environment: iOS 17+ Optimized")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

// High-Performance Webview for Streaming
struct GameStreamView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.allowsAirPlayForMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.backgroundColor = .black
        webView.scrollView.isScrollEnabled = false // Prevent accidental scrolling during play
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
