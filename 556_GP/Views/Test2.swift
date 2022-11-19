//
//  Test2.swift
//  556_GP
//
//  Created by Dzianis Shakhalevich on 11/18/22.
//

import SwiftUI

struct Test2: View {
    @State var shan = true
    
    var body: some View {
        VStack{
            Test(strokeColor: Color("LightGray"), shan: shan)
                .frame(width: 300, height: 100)

            Button {
                shan = true
            } label: {
                Text("fds")
            }

        }
    }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2(shan: false)
    }
}
