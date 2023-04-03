//
//  ChargingOperationsView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 28.03.2023.
//

import Firebase
import SwiftUI

struct ChargingOperationsView: View {
    @State var selectdElement = ChargereModel(id: "", title: "", avaliable: 0, latitude: 12.22, longitude: 12.22)
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
                                    .foregroundColor(self.selectdElement.avaliable == 0 && charger.isAvaliable(currentCharger: selectdElement, rezervations: rezervationViewModel.reservations) ? .green : .red)

                                Text(self.selectdElement.avaliable == 0 && charger.isAvaliable(currentCharger: selectdElement, rezervations: rezervationViewModel.reservations) ? "Musait" : "Musait Degil")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.white)

                            }.padding(.horizontal)

                            Picker("chargers", selection: $selectdElement) {
                                ForEach(rezervationViewModel.myChargers) { element in
                                    HStack {
                                        
                                        Text(element.title)
                                        if element.avaliable == 0 {
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

                            Spacer()

                            HStack {
                                Text("Seçilen Charger:")
                                Text("\(self.selectdElement.title)")
                                    .bold()
                            }
                        }
                    }
                }
                .padding(.horizontal)

                HStack {
                    Button {
                        
                            if self.selectdElement.id != "" {
                                if self.selectdElement.avaliable == 0 && charger.isAvaliable(currentCharger: selectdElement, rezervations: rezervationViewModel.reservations){
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
                                        "chargerTitle": selectdElement.title,
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
                                    self.selectdElement.avaliable = 1

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
                                .background(selectdElement.avaliable == 0 && charger.isAvaliable(currentCharger: selectdElement, rezervations: rezervationViewModel.reservations)  ? .green : .red)
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
                            self.selectdElement.avaliable = 0

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
            charger.updateAvaliable(param: selectdElement.id, avaliable: 1)
        } else {
            charger.updateAvaliable(param: selectdElement.id, avaliable: 0)
        }
    }
}

struct ChargingOperationsView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingOperationsView()
    }
}
