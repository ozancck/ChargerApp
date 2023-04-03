//
//  Service.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import FirebaseCore
import FirebaseFirestore
import Foundation

class ChargerService: ObservableObject {
    @Published var chargers2 = [ChargereModel]()

    func fetchChargers() {
        let db = Firestore.firestore()
        db.collection("Chargers").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var chargers = [ChargereModel]() // create an empty array
                for document in querySnapshot!.documents {
                    // create a ChargereModel object from each document
                    let charger = ChargereModel(
                        id: document.documentID as? String ?? "",
                        title: document.get("title") as? String ?? "",
                        avaliable: document.get("avaliable") as? Int ?? 0,
                        latitude: document.get("latitude") as? Double ?? 0,
                        longitude: document.get("longitude") as? Double ?? 0
                    )
                    // append the object to the array
                    chargers.append(charger)
                }
                // assign the array to chargers2
                self.chargers2 = chargers
            }
        }
    }

    func updateAvaliable(param: String, avaliable: Int) {
        let db = Firestore.firestore()
        db.collection("Chargers").document(param).updateData([
            "avaliable": avaliable,

        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }

    func fetchUserChargers(chargers: [ChargereModel], reservations: [Reservation]) -> [ChargereModel] {
        var userChargers = [ChargereModel]()

        for charger in chargers {
            for reservation in reservations {
                if charger.id == reservation.charger.id {
                    userChargers.append(charger)
                }
            }
        }

        return userChargers
    }

    func isAvaliable(currentReservation: Reservation, rezervations: [Reservation]) -> Bool {
        for rezervation in rezervations {
            
            let string1 = "dd/MM/yyyy"
            let string2 = "HH:mm"

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "\(string1) \(string2)"
            let sDate = dateFormatter.date(from: "\(rezervation.startDate) \(rezervation.startTime)" )
            let eDate = dateFormatter.date(from: "\(rezervation.endDate) \(rezervation.endTime)")
            


            if rezervation.id == currentReservation.id {
                
                let now = Date()
                
                if now >= sDate! && now <= eDate! {
                    print("helalalal laaa")
                    return true
                }else{
                    print("uygun tarihler degil")
                }
               
            }
        }

        return false
    }
}
