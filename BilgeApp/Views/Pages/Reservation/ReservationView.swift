//
//  ReservationView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 28.03.2023.
//

import SwiftUI

struct ReservationView: View {
    @State private var startDate = Date()
    @State private var startTime = Date()
    
    @StateObject var reservationViewModel = ReservationViewModel()
    
  
    
    
    @State var currentCharger = ChargereModel(id: "", title: "elma", avaliable: 0, latitude: 123121.123, longitude: 121.12)

    var body: some View {
        NavigationStack {
            
            
            
            
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.dateFormat = "dd/MM/yyyy"
                return formatter
            }()

            let timeFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                return formatter
            }()

            VStack {
                HStack {
                    Text("Başlangıç Tarihi Seçiniz")
                        .font(.title2)
                        .bold()

                    NavigationLink {
                        
                        
                        EndDateReservationView(startDate: reservationViewModel.dateString(param: self.startDate) , startTime: reservationViewModel.timeString(param: self.startTime) , currentCharger: self.currentCharger)
                    }
                    label: {
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
                .padding()

                HStack {
                    Text("Seçilen Charger: ")

                    Text("\(currentCharger.title)")
                        .bold()
                }

                DatePicker("", selection: $startDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()

                DatePicker("Saat Seciniz:", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.graphical)
                    .padding()

                VStack {
                    Text("Seçilen Başlangıç Tarihi:")
                        .bold()

                    HStack {
                        Text("\(startDate, formatter: dateFormatter)")

                        Text("\(startTime, formatter: timeFormatter)")
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

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
