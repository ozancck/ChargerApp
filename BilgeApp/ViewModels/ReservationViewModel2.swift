//
//  ReservationViewModel2.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 31.03.2023.
//

import Firebase
import Foundation

class ReservationViewModel2: ObservableObject {
    
    
    
    func addReservation(reservation: ReservationModel2) {
        
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "startDate": reservation.startDate,
            "endDate": reservation.endDate,
            "userId": reservation.userId,
            "charger": reservation.charger,
        ]
        db.collection("reservations2").addDocument(data: data) { error in
            if let error = error {
                print("Error adding reservation: \(error)")
            } else {
                print("Reservation added successfully!")
            }
        }
    }
    
    
    
}
