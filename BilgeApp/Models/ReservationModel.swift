//
//  ReservationModel.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 30.03.2023.
//

import Foundation

struct Reservation: Hashable {
    
    var id: String
    var startDate: String
    var startTime: String
    var endDate: String
    var endTime: String
    var userId: String
    var charger: ChargereModel
}

extension Reservation: Identifiable {
}
