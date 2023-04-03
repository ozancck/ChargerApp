//
//  Login.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import Firebase
import SwiftUI

struct Login: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""

    var body: some View {
        ZStack {
            ZStack(alignment: .topTrailing) {
                GeometryReader { _ in

                    VStack {
                        
                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)

                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)

                        HStack(spacing: 15) {
                            VStack {
                                if self.visible {
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }

                            Button(action: {
                                self.visible.toggle()

                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)

                        HStack {
                            Spacer()

                            Button(action: {
                                self.reset()

                            }) {
                                Text("Forget password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .padding(.top, 20)

                        Button(action: {
                            self.verify()

                        }) {
                            Text("Log in")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 150)
                }

                Button(action: {
                    self.show.toggle()

                }) {
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                }
                .padding()
            }

            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }

    func verify() {
        if email != "" && pass != "" {
            Auth.auth().signIn(withEmail: email, password: pass) { _, err in

                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }

                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        } else {
            error = "Please fill all the contents properly"
            alert.toggle()
        }
    }

    func reset() {
        if email != "" {
            Auth.auth().sendPasswordReset(withEmail: email) { err in

                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }

                self.error = "RESET"
                self.alert.toggle()
            }
        } else {
            error = "Email Id is empty"
            alert.toggle()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(show: .constant(false))
    }
}
