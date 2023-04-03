//
//  ChargingOperationsView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 28.03.2023.
//

import Firebase
import SwiftUI

struct ChargingOperationsView: View {
    
    @State var selectedReservation = Reservation(id: "", startDate: "", startTime: "", endDate: "", endTime: "", userId: "", charger: ChargereModel(id: "", title: "", avaliable: 1, latitude: 0, longitude: 0))
    
    @State var succes = true
    @State var clicked: Bool = true
    @StateObject var charger = ChargerService()
    @StateObject var rezervationViewModel = ReservationViewModel()
    
    @State var reservationAvaliable = false

    @State var currentProcessId = ""
    @State var startTime = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Şarj İşlemleri")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.black.opacity(0.8))
                            .scaleEffect(1.3)

                        Circle()
                            .foregroundColor(Color(.black).opacity(1))

                        VStack {
                            Spacer()

                            Text("Şarj Cihazı Seç")
                                .font(.title3)
                                .padding()
                                .bold()
                                .foregroundColor(.white)

                            VStack {
                                Image(systemName: "battery.75")
                                    .font(.largeTitle)
                                    .foregroundColor(self.selectedReservation.charger.avaliable == 0 && charger.isAvaliable(currentReservation: selectedReservation, rezervations: rezervationViewModel.reservations) ? .green : .red)

                                Text(self.selectedReservation.charger.avaliable == 0 && charger.isAvaliable(currentReservation: selectedReservation, rezervations: rezervationViewModel.reservations) ? "Musait" : "Musait Degil")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                
                                
                               
                                

                            }.padding(.horizontal)

                            Picker("chargers", selection: $selectedReservation) {
                                ForEach(rezervationViewModel.reservations) { element in
                                    HStack {
                                        
                                        Text(element.charger.title)
                                        if element.charger.avaliable == 0 {
                                            Image(systemName: "wifi")

                                        } else {
                                            Image(systemName: "wifi.exclamationmark")
                                        }
                                    }
                                    .tag(element)
                                    
                                }
                            }
                            .onAppear{
                                rezervationViewModel.fetchMyChargers()
                            }
                            .foregroundColor(.black)
                            .pickerStyle(.menu)
                            
                            
                            VStack{
                                HStack{
                                    Text(self.selectedReservation.startDate)
                                    Text(self.selectedReservation.startTime)
                                    
                                }
                                .font(.title2)
                                .bold()
                                .foregroundColor( charger.isAvaliable(currentReservation: selectedReservation, rezervations: rezervationViewModel.reservations) ? .green : .red)
                                
                                HStack{
                                    Text(self.selectedReservation.endDate)
                                    Text(self.selectedReservation.endTime)
                                }
                                .font(.title2)
                                .bold()
                                .foregroundColor( charger.isAvaliable(currentReservation: selectedReservation, rezervations: rezervationViewModel.reservations) ? .green : .red)
                          
                            }

                            Spacer()

                            HStack {
                                Text("Seçilen Charger:")
                                Text("\(self.selectedReservation.charger.title)")
                                    .bold()
                            }
                        }
                    }
                }
                .padding(.horizontal)

                HStack {
                    Button {
                        
                        if self.selectedReservation.charger.id != "" {
                            if self.selectedReservation.charger.avaliable == 0 && charger.isAvaliable(currentReservation: selectedReservation, rezervations: rezervationViewModel.reservations){
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateStyle = .medium
                                    dateFormatter.timeStyle = .medium
                                    let date = Date()
                                    let dateString = dateFormatter.string(from: date)
                                    self.startTime = dateString

                                    self.succes = true
                                    print("basarili")

                                    let db = Firestore.firestore()
                                    let user = Auth.auth().currentUser

                                    let ref = db.collection("UsersInfo").document()

                                    self.currentProcessId = ref.documentID
                                    ref.setData([
                                        "userMail": user?.email ?? "",
                                        "chargerTitle": selectedReservation.charger.title,
                                        "chargeStartDate": dateString,
                                        "chargeStopDate": "",
                                        "totalTime": "",
                                    ]) { err in
                                        if let err = err {
                                            print("Error adding document: \(err)")
                                        } else {
                                            print("Document added with ID: \(self.currentProcessId)")
                                        }
                                    }

                                    self.clicked = false

                                    avaliable()
                                self.selectedReservation.charger.avaliable = 1

                                } else {
                                    print("hata")
                                    self.succes = false
                                }
                            }
                        
                    }
                    label: {
                        if clicked {
                            Text("Sarji Baslat")
                                .foregroundColor(.white)
                                .padding()
                                .background(selectedReservation.charger.avaliable == 0 && charger.isAvaliable(currentReservation: selectedReservation, rezervations: rezervationViewModel.reservations)  ? .green : .red)
                                .cornerRadius(15)
                        } else {
                            Text("Sarj Oluyor")
                                .foregroundColor(.black)
                                .padding()
                                .background(.yellow)
                                .cornerRadius(15)
                        }
                    }
                    .padding()

                    if self.clicked == false {
                        Button {
                            self.clicked = true

                            let db = Firestore.firestore()
                            let docRef = db.collection("UsersInfo").document(self.currentProcessId)

                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .medium
                            dateFormatter.timeStyle = .medium
                            let date = Date()
                            let dateString = dateFormatter.string(from: date)

                            // Set the "name" field of the user 'user1'
                            docRef.updateData([
                                "chargeStopDate": String(dateString),
                                "totalTime": "",
                            ]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                }
                            }

                            avaliable()
                            self.selectedReservation.charger.avaliable = 0

                        } label: {
                            withAnimation {
                                Text("Durdur")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.red)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                Spacer()
            }
            .onAppear{
                charger.fetchChargers()
                rezervationViewModel.fetchReservation()
                
            }

            
        }
       
    }

    func avaliable() {
        if clicked == false {
            charger.updateAvaliable(param: selectedReservation.charger.id, avaliable: 1)
        } else {
            charger.updateAvaliable(param: selectedReservation.charger.id, avaliable: 0)
        }
    }
}

struct ChargingOperationsView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingOperationsView()
    }
}
