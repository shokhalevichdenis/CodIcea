// Chart with the wrong answers.

import SwiftUI
import Charts

struct V_ReviewPage: View {
    @Binding var lWrongAnswersForPlot: [[Int]]

    var body: some View {
        
        NavigationStack {
            VStack{
                Text("Wrong Answers")
                    .font(Font.custom("Futura Medium", size: 23))
                    .multilineTextAlignment(.leading)
                Spacer()
                Chart {
                    ForEach(lWrongAnswersForPlot, id: \.self) { t in
                        LineMark(x: .value("Wrong Answers", t[0]), y: .value("Number of Questions", t[1]))
                    }
                    .foregroundStyle(.red.opacity(0.8))
                }
                .chartLegend(position: .overlay, alignment: .center, spacing: 0)
                .padding(20)
            }
            .navigationTitle("Results")
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
    }
}

struct V_ReviewPage_Previews: PreviewProvider {
    static var previews: some View {
        V_ReviewPage(lWrongAnswersForPlot: Binding.constant([[0,0]]))
    }
}
