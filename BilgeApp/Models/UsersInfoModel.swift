//
//  UsersInfoModel.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import Foundation

struct UserInfoModel: Hashable {
    
    var id : String
    var chargeStartDate: String
    var chargeStopDate: String
    var chargerTitle: String
    var totalTime: String
    var userMail: String
}

extension UserInfoModel: Identifiable {
    
}

