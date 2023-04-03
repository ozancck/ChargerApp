//
//  ReservationViewModel.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 30.03.2023.
//

import Firebase
import Foundation

class ReservationViewModel: ObservableObject {
    @Published var reservations = [Reservation]()

    @Published var myChargers = [ChargereModel]()

    func fetchReservation() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser

        guard let uid = user?.uid else {
            print("User email not found!")

            return
        }

        db.collection("reservations").whereField("userId", isEqualTo: uid).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")

            } else {
                var reservations = [Reservation]()
                
                for document in querySnapshot!.documents {
                    let chargerDict = document.data()["charger"] as! [String: Any]
                    let charger = ChargereModel(
                        id: chargerDict["id"] as! String,
                        title: chargerDict["title"] as! String,
                        avaliable: chargerDict["avaliable"] as! Int,
                        latitude: chargerDict["latitude"] as! Double,
                        longitude: chargerDict["longitude"] as! Double
                    )

                    let reservation = Reservation(
                        id: document.documentID,
                        startDate: document.get("startDate") as? String ?? "",
                        startTime: document.get("startTime") as? String ?? "",
                        endDate: document.get("endDate") as? String ?? "",
                        endTime: document.get("endTime") as? String ?? "",
                        userId: document.get("userId") as? String ?? "",
                        charger: charger
                    )

                    reservations.append(reservation)
                }
                
                self.reservations = reservations
            }
        }
    }
    

    func addReservation(reservation: Reservation) {
        let db = Firestore.firestore()

        let chargerDictionary: [String: Any] = [
            "id": reservation.charger.id,
            "title": reservation.charger.title,
            "avaliable": reservation.charger.avaliable,
            "latitude": reservation.charger.latitude,
            "longitude": reservation.charger.longitude,
        ]

        let data: [String: Any] = [
            "startDate": reservation.startDate,
            "startTime": reservation.startTime,
            "endDate": reservation.endDate,
            "endTime": reservation.endTime,
            "userId": reservation.userId,
            "charger": chargerDictionary,
        ]
        db.collection("reservations").addDocument(data: data) { error in
            if let error = error {
                print("Error adding reservation: \(error)")
            } else {
                print("Reservation added successfully!")
            }
        }
    }

    func fetchMyChargers() {
        var charger = [ChargereModel]()
        for reservation in reservations {
            charger.append(reservation.charger)
        }
        
        self.myChargers = charger
        
    }
    
    
    func dateString(param: Date)-> String{
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter
        }()

        return dateFormatter.string(from: param)
    }
    
    
    func timeString(param: Date)-> String{
        
        let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter
        }()

        return timeFormatter.string(from: param)
    }
}
