//
//  ReservationModel2.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 31.03.2023.
//

import Foundation

struct ReservationModel2: Hashable {
    
    var id: String
    var startDate: Date
    var endDate: Date
    var userId: String
    var charger: ChargereModel
}



extension ReservationModel2: Identifiable {
}
