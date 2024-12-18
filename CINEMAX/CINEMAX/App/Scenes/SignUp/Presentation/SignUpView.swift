//
//  SignUpView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 05/12/2024.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    Image("CINEMAX")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    
                    Text("Let's get started")
                        .fontWeight(.semibold)
                        .font(.system(size: 24))
                        .foregroundColor(Color.blueAccent)
                    
                    TextField("", text: $viewModel.username, prompt: Text("Username")
                        .foregroundColor(.grayAccent)
                    )
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).strokeBorder(Color.grayAccent, lineWidth: 1))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 18)
                    .frame(height: 50)

                    TextField("", text: $viewModel.firstName, prompt: Text("First Name")
                        .foregroundColor(.grayAccent)
                    )
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).strokeBorder(Color.grayAccent, lineWidth: 1))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 18)
                    .frame(height: 50)

                    TextField("", text: $viewModel.lastName, prompt: Text("Last Name")
                        .foregroundColor(.grayAccent)
                    )
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).strokeBorder(Color.grayAccent, lineWidth: 1))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 18)
                    .frame(height: 50)

                    TextField("", text: $viewModel.email, prompt: Text("Email Address")
                        .foregroundColor(.grayAccent)
                    )
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).strokeBorder(Color.grayAccent, lineWidth: 1))
                    .foregroundColor(Color.white)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 18)
                    .frame(height: 50)
                    
                    SecureField("", text: $viewModel.password, prompt: Text("Password")
                        .foregroundColor(.grayAccent)
                    )
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).strokeBorder(Color.grayAccent, lineWidth: 1))
                    .foregroundColor(Color.white)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.horizontal, 18)
                    .frame(height: 50)
                    
                    if !viewModel.error.isEmpty {
                        Text(viewModel.error)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .foregroundStyle(.red)
                    }

                    Button(action: {
                        viewModel.signUpTapped.send()
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(RoundedRectangle(cornerRadius: 24).fill(Color.blueAccent))
                                .padding(.horizontal, 18)
                        } else {
                            Text("Sign Up")
                                .fontWeight(.medium)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .foregroundStyle(.white)
                                .background(RoundedRectangle(cornerRadius: 24).fill(Color.blueAccent))
                                .padding(.horizontal, 18)
                        }
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .foregroundStyle(.grayAccent)
                        
                        Button("Login") {
                            viewModel.loginTapped.send()
                        }
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .foregroundStyle(.blueAccent)
                    }
                }

                NavigationLink(
                    destination: LoginView(viewModel: LoginViewModel(username: viewModel.username, password: viewModel.password)),
                    isActive: $viewModel.showLogin
                ) {
                    EmptyView()
                }
            }
            .background(.darkAccent)
        }
        .navigationBarHidden(true)
    }
}
