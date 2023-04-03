//
//  AylikGetirView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 28.03.2023.
//

import SwiftUI

struct AylikGetirView: View {
    
    @StateObject var model = AylikGetirViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    List(model.userInfo) { element in

                        NavigationLink {
                            UsageDetail(chargeStartDate: element.chargeStartDate, chargeStopDate: element.chargeStopDate, chargerTitle: element.chargerTitle, totalTime: element.totalTime, userMail: element.userMail)
                        } label: {
                            Text(element.chargeStartDate)
                                
                        }
                    }

                }
            }.onAppear {
                model.fetchData()
            }
            .navigationTitle("Son Kullanimlar")
        }
    }
}

struct AylikGetirView_Previews: PreviewProvider {
    static var previews: some View {
        AylikGetirView()
    }
}
