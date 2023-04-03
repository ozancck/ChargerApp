//
//  ReservationTabView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 30.03.2023.
//

import SwiftUI

struct ReservationTabView: View {
    var body: some View {
        TabView {
            ReservationView()

            EndDateReservationView()
            
            Reservation_ConfirmationView()
        }

        .tabViewStyle(.page)
        
    }
}

struct ReservationTabView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationTabView()
    }
}
