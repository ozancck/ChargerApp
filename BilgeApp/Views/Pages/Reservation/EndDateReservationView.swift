//
//  EndDateReservationView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 30.03.2023.
//

import SwiftUI

struct EndDateReservationView: View {
    @State var startDate : String = ""
    @State var startTime : String = ""

    @State private var endDate = Date()
    @State private var endTime = Date()
    
    @StateObject var reservationViewModel = ReservationViewModel()
    
    @State var currentCharger = ChargereModel(id: "", title: "elma", avaliable: 0, latitude: 123121.123, longitude: 121.12)

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
                HStack {
                    Text("Bitiş Tarihi Seçiniz")
                        .font(.title2)
                        .bold()

                    NavigationLink {
                        Reservation_ConfirmationView(currentCharger: currentCharger, startDate: self.startDate, endDate: reservationViewModel.dateString(param: self.endDate), startTime: self.startTime, endTime: reservationViewModel.timeString(param: self.endTime))

                    } label: {
                        HStack {
                            Spacer()
                            HStack(alignment: .center) {
                                Text("İleri")
                                    .bold()
                                    .font(.caption)

                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.title3)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(.black).opacity(0.8))
                            .cornerRadius(17)
                        }
                        .padding()
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Seçilen Charger: ")

                    Text("\(currentCharger.title)")
                        .bold()
                }

                VStack {
                    DatePicker("", selection: $endDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding()

                    DatePicker("Saat Seciniz:", selection: $endTime, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.graphical)
                        .padding()
                }
                .padding(.horizontal)

                VStack {
                    Text("Seçilen Bitiş Tarihi:")
                        .bold()
                    HStack {
                        Text("\(endDate, formatter: dateFormatter)")

                        Text("\(endTime, formatter: timeFormatter)")
                    }
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(Color(.red).opacity(0.8))
                .cornerRadius(17)
            }
            .padding()

           
        }
    }
}

struct EndDateReservationView_Previews: PreviewProvider {
    static var previews: some View {
        EndDateReservationView()
    }
}
