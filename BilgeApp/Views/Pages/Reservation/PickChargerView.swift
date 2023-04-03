//
//  PickChargerView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 31.03.2023.
//

import SwiftUI

struct PickChargerView: View {
    @StateObject var charger = ChargerService()
    var body: some View {
        NavigationStack{
            VStack{
                List(charger.chargers2){element in
                    NavigationLink{
                        ReservationView(currentCharger: ChargereModel(id: element.id, title: element.title, avaliable: element.avaliable, latitude: element.latitude, longitude: element.longitude))
                    }label: {
                        HStack(alignment: .center){
                            Text(element.title)
                                .bold()
                            Spacer()
                            Text("now")
                            if element.avaliable == 1 {
                                Image(systemName:"wifi.exclamationmark")
                                    .foregroundColor(.red)
                            }else{
                                Image(systemName:"wifi")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                .navigationTitle("Pick Chargers")
            }.onAppear{
                charger.fetchChargers()
            }
        }
    }
}

struct PickChargerView_Previews: PreviewProvider {
    static var previews: some View {
        PickChargerView()
    }
}
