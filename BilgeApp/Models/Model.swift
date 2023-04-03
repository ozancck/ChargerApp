//
//  Model.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 28.03.2023.
//

import Foundation

struct ChargereModel: Hashable {
    
    var id : String
    var title: String
    var avaliable: Int
    var latitude: Double
    var longitude: Double
    
  
    
}

extension ChargereModel: Identifiable {
}


