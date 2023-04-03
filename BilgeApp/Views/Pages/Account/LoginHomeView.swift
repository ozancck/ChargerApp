//
//  LoginHomeView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import SwiftUI

struct LoginHomeView: View {
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View {
        NavigationView {
            VStack {
                if self.status {
                    MyTabView()
                } else {
                    ZStack {
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            Text("")
                        }
                        .hidden()

                        Login(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { _ in

                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
 	   
        
        
     
}

struct LoginHomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHomeView()
    }
}
