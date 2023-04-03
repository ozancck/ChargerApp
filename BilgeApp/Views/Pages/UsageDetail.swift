//
//  UsageDetail.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import SwiftUI

struct UsageDetail: View {
    @State var chargeStartDate: String
    @State var chargeStopDate: String
    @State var chargerTitle: String
    @State var totalTime: String
    @State var userMail: String
    
    
    
    
     var body: some View {
         VStack(alignment: .leading){
             Text("charge start: \(chargeStartDate)")
                 .bold()
             Text("charge stop: \(chargeStopDate)")
                 .bold()
             Text("cahrge name:  \(chargerTitle)")
                 .bold()
             Text("totale charge time: \(totalTime)")
                 .bold()
             Text("user: \(userMail)")
                 .bold()
         }
    }
}

struct UsageDetail_Previews: PreviewProvider {
    static var previews: some View {
        UsageDetail(chargeStartDate: "", chargeStopDate: "", chargerTitle: "", totalTime: "", userMail: "")
    }
}
