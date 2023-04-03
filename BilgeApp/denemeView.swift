//
//  denemeView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import MapKit
import SwiftUI

struct denemeView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.0415, longitude: 27.4215), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
    @StateObject var charger = ChargerService()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $region, annotationItems: charger.chargers2) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    Button {
                        withAnimation {
                            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude + -0.0008, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
                        }

                    } label: {
                        VStack {
                            if location.avaliable == 0 {
                                Image(systemName: "bolt.square.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.green)
                                    .border(.white, width: 1)

                            } else {
                                Image(systemName: "bolt.square.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    .border(.white, width: 1)
                            }
                            Text(location.title)
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        
    }
}

struct denemeView_Previews: PreviewProvider {
    static var previews: some View {
        denemeView()
    }
}
