//
//  PickerCellView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 31.03.2023.
//

import SwiftUI

struct PickerCellView: View {
    
    @State var title: String
    @State var avaliable: Int
    @State var latitude: Double = 0.1
    @State var longitude: Double = 0.1
    
    var body: some View {
        VStack{
            Text(title)
                .font(.title2)
        }
    }
}

struct PickerCellView_Previews: PreviewProvider {
    static var previews: some View {
        PickerCellView(title: "ModelX", avaliable: 0)
    }
}
