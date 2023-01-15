import SwiftUI
import WebKit
import Combine

class WebViewData: ObservableObject {
    @Published var parsedText: NSAttributedString? = nil
    
    var functionCaller = PassthroughSubject<Void,Never>()
    
    var isInit = false
    var shouldUpdateView = true
}

struct WebView: UIViewRepresentable {
    var question: String = "default"
    @StateObject var data: WebViewData
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.navigationDelegate = context.coordinator
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard data.shouldUpdateView else {
            data.shouldUpdateView = false
            return
        }
        
        context.coordinator.webView = uiView
        
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            uiView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(view: self)
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    var webView: WKWebView? = nil
    
    private var cancellable : AnyCancellable?
    
    init(view: WebView) {
        self.parent = view
        super.init()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            if !self.parent.data.isInit {
                self.parent.data.isInit = true
                webView.evaluateJavaScript("updateQuestion('\(self.parent.question.replacingOccurrences(of: "\n", with: "\\n"))'); hljs.highlightAll();")
            }
        }
    }
}

struct V_QuestionWebView: View {
    @StateObject var webViewData = WebViewData()
    var question : String
    
    init(question: String?) {
        self.question = question ?? "Sorry, this reading is empty"
    }
    
    var body: some View {
        WebView(question: question, data: webViewData)
            .frame(height: 160)
        
            .onReceive(webViewData.$parsedText, perform: { parsedText in
                if let parsedText = parsedText {
                    print(parsedText)
                }
            })
    }
}

struct V_QuestionWebView_Preview: PreviewProvider {
    static var previews: some View {
        V_QuestionWebView(question: QuizViewModel().quizzesData[0].question)
            .environmentObject(QuizViewModel())
    }
}

