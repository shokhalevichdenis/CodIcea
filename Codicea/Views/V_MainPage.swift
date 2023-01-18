// Main page with the list of programming languages.

import SwiftUI

struct V_MainPage: View {
    var body: some View {
        let languages: [[String]] = [["Swift", "swift"], ["JavaScript", "heart.fill"], ["Python", "scribble"], ["C#", "number"], ["C++", "plusminus"], ["PHP", "figure.fall"], ["Java", "cup.and.saucer"]]
        NavigationStack{
            VStack{
                Text("What's your pleasure?")
                    .font(Font.custom("Futura Medium", size: 23))
                    .multilineTextAlignment(.leading)
                ScrollView{
                    ForEach(languages, id: \.self) { language in
                        NavigationLink(destination: V_QuizList(chosenLanguage: language[0])) {
                            StartPageButton(labelValue: language[0], imageValue: language[1])
                        }
                    }
                }
                .scrollIndicators(.hidden)
                Spacer()
            }
            .navigationTitle("Languages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("codIcea")
                            .font(Font.custom("Futura Medium", size: 25))
                            .foregroundColor(.green.opacity(0.80))
                            .multilineTextAlignment(.center)
                            .frame(width: 200, height: 20)
                    }
                }
            }
        }
        .accentColor(.black)
    }
}

// Menu buttons.
struct StartPageButton: View {
    var labelValue: String
    var imageValue: String
    
    var body: some View {
        VStack{
            Image(systemName: imageValue)
                .foregroundColor(.black)
                .frame(width: 35, height: 35)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 1)
            Text(labelValue)
                .font(Font.custom("Futura Medium", size: 18))
                .foregroundColor(.black)
        }
        .frame(width: 300, height: 100)
        .background(Capsule()
            .stroke(LinearGradient(gradient: Gradient(colors: [.green.opacity(0.8), Color("LightGray"), .green.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing), style: .init(lineWidth: 1, lineCap: .round, lineJoin: .round))
        )
        .padding(.bottom, 7)
    }
}

struct V_MainPage_Previews: PreviewProvider {
    static var previews: some View {
        V_MainPage()
            .environmentObject(QuizViewModel())
    }
}
