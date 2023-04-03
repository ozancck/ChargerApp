//
//  PickerCellView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 31.03.2023.
//

import SwiftUI

struct PickerCellView: View {
    
    @State var selectdElement = ChargereModel(id: "", title: "", avaliable: 0, latitude: 12.22, longitude: 12.22)
    @StateObject var rezervationViewModel = ReservationViewModel()
    
    
    var body: some View {
        VStack{
            ForEach(rezervationViewModel.reservations){element in
                
                if selectdElement.id == element.chargerId {
                    HStack {
                        Text(selectdElement.title)
                        if selectdElement.avaliable == 1 {
                            Image(systemName: "wifi.exclamationmark")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "wifi")
                                .foregroundColor(.green)
                        }

                    }
                }
                
                
                
            }
                
        }.onAppear{
            rezervationViewModel.fetchRezervation()
        }
    }
}

struct PickerCellView_Previews: PreviewProvider {
    static var previews: some View {
        PickerCellView()
    }
}
