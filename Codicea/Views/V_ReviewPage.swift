// Chart with the wrong answers.

import SwiftUI
import Charts

struct V_ReviewPage: View {
    @FetchRequest(sortDescriptors: []) var userQuizAggregated: FetchedResults<UserQuizAggregated>
    
    func dateToHours(_ date: Date) -> Int? {
        let date: Date = date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        let hours = components.hour
        return hours
    }

    
    var body: some View {
        
        NavigationStack {
            VStack{
                Text("Statistics")
                    .font(Font.custom("Futura Medium", size: 23))
                    .multilineTextAlignment(.center)
                Spacer()
            
                Chart {
                    ForEach(userQuizAggregated, id: \.id) { row in
                        LineMark(x: .value("Attempt", row.id), y: .value("Wrong Answers", row.wronggAnswers), series: .value("Answers", "Wrong"))
                            .foregroundStyle(.red.opacity(0.8))
                    }
                    
                    ForEach(userQuizAggregated, id: \.id) { row in
                        LineMark(x: .value("Attempt", row.id), y: .value("Correct Answers", row.correctAnswers), series: .value("Answers", "Correct"))
                            .foregroundStyle(.green.opacity(0.8))
                    }
                    
                    ForEach(userQuizAggregated, id: \.id) { row in
                        LineMark(x: .value("Attempt", row.id), y: .value("Skipped Answers", row.skippedAnswers), series: .value("Answers", "Skipped"))
                            .foregroundStyle(.gray.opacity(0.8))
                    }
                }
                .chartForegroundStyleScale(["Wrong": .red.opacity(0.8), "Correct": .green.opacity(0.8), "Skipped": .gray.opacity(0.8) ])
                .chartLegend(position: .overlay, alignment: .top)
                .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 5))
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
        V_ReviewPage()
    }
}
