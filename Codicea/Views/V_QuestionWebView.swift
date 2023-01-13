import SwiftUI
import WebKit

struct QuestionWebView: View {
    var body: some View {
        VStack() {
            WebView(url: URL(filePath: "index.html"))
        }
    }
}

struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
}

struct QuestionWebView_Preview: PreviewProvider {
    static var previews: some View {
        QuestionWebView()
    }
}
