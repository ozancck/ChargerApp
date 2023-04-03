//
//  MyTabView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 28.03.2023.
//

import SwiftUI

struct MyTabView: View {
   

    var body: some View {
        TabView {
            ChargingOperationsView()
                .tabItem {
                    Label("Şarj İşlemleri", systemImage: "externaldrive.fill.badge.wifi")
                }

            PickChargerView()
                .ignoresSafeArea(.all)
                .tabItem {
                    Label("Rezervasyon", systemImage: "calendar.badge.clock")
                }

            AylikGetirView()
                .tabItem {
                    Label("Aylık Getir", systemImage: "waveform.path.ecg.rectangle.fill")
                }

            AnnualUsageView()
                .tabItem {
                    Label("Yıllık Kullanım", systemImage: "waveform.path.ecg.rectangle.fill")
                }

            ChargingCentersView()
                .tabItem {
                    Label("Şarj Merkezleri", systemImage: "mappin.square.fill")
                }
        }
        .tableStyle(.inset)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

           
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
