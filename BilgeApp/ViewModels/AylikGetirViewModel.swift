//
//  AylikGetirViewModel.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import Firebase
import Foundation

class AylikGetirViewModel: ObservableObject {
    @Published var userInfo = [UserInfoModel]()

    func fetchData() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        guard let userEmail = user?.email else {
            print("User email not found!")
            return
        }

        db.collection("UsersInfo").whereField("userMail", isEqualTo: userEmail).getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var userInfo = [UserInfoModel]()
                for document in querySnapshot!.documents {
                    let infos = UserInfoModel(
                        id: document.documentID,
                        chargeStartDate: document.get("chargeStartDate") as? String ?? "",
                        chargeStopDate: document.get("chargeStopDate") as? String ?? "",
                        chargerTitle: document.get("chargerTitle") as? String ?? "",
                        totalTime: document.get("totalTime") as? String ?? "",
                        userMail: document.get("userMail") as? String ?? "")

                    userInfo.append(infos)
                }

                self.userInfo = userInfo
                print(userInfo) // userInfo güncellendiği zaman yazdırın
            }
        }
    }

}
