//
//  Reservation ConfirmationView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 30.03.2023.
//

import Firebase
import SwiftUI

struct Reservation_ConfirmationView: View {
    @StateObject var rezervation = ReservationViewModel()

    @State var currentCharger = ChargereModel(id: "", title: "elma", avaliable: 0, latitude: 123121.123, longitude: 121.12)

    @State var startDate: String = ""
    @State var endDate: String = ""
    @State var startTime: String = ""
    @State var endTime: String = ""

    var body: some View {
        NavigationStack {
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                return formatter
            }()

            let timeFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                return formatter

            }()

            VStack {
                Text("Özet")
                    .font(.title)
                    .bold()

                HStack {
                    Text("Seçilen Charger: ")

                    Text("\(currentCharger.title)")
                        .bold()
                }.padding()

                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Rendevu Başlangıç Tarihi")
                            .bold()
                        Text(self.startDate)
                        Text(self.startTime)
                    }

                    .padding()

                    VStack(alignment: .leading) {
                        Text("Rendevu Bitiş Tarihi")
                            .bold()
                        Text(self.endDate)
                        Text(self.endTime)
                    }

                    .padding()
                }

                Button {
                    let user = Auth.auth().currentUser

                    guard let userId = user?.uid else {
                        print("User Id not found!")
                        return
                    }

                    rezervation.addReservation(reservation: Reservation(id: "", startDate: String(self.startDate), startTime: String(self.startTime), endDate: String(self.endDate), endTime: String(self.endTime), userId: userId, charger: self.currentCharger))
                } label: {
                    Text("Onayla")
                        .frame(width: 100)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(.black).opacity(0.8))
                        .cornerRadius(17)
                        .padding(.top, 100)
                }
            }
        }
    }
}

struct Reservation_ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        Reservation_ConfirmationView()
    }
}
