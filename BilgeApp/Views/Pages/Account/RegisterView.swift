//
//  RegisterView.swift
//  BilgeApp
//
//  Created by Ozan Çiçek on 29.03.2023.
//

import Firebase
import SwiftUI

struct RegisterView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""

    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { _ in
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
                        .padding(.top, 75)

                    Text("Log in to your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 35)

                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)

                    HStack(spacing: 15) {
                        VStack {
                            if self.visible {
                                TextField("Password", text: self.$pass)
                            } else {
                                SecureField("Password", text: self.$pass)
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

                    HStack(spacing: 15) {
                        VStack {
                            if self.revisible {
                                TextField("Re-enter", text: self.$repass)
                            } else {
                                SecureField("Re-enter", text: self.$repass)
                            }
                        }

                        Button(action: {
                            self.revisible.toggle()
                        }) {
                            Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") : self.color, lineWidth: 2))
                    .padding(.top, 25)

                    Button {
                        Auth.auth().createUser(withEmail: email, password: pass) { _, error in
                            if let error = error {
                                print("Error creating user: \(error.localizedDescription)")
                            } else {
                                print("User created successfully!")
                            }
                        }
                    } label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
                .padding(.horizontal, 25)
            }

            Button {
                self.show.toggle()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(Color("Color"))
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }

    func register() {
        if email != "" {
            if pass == repass {
                Auth.auth().createUser(withEmail: email, password: pass) { _, err in

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
                error = "Password mismatch"
                alert.toggle()
            }
        } else {
            error = "Please fill all the contents properly"
            alert.toggle()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(show: .constant(false))
    }
}
