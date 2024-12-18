//
//  LoginView.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 07/12/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: LoginViewModel) {
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
                    
                    Text("Welcome back!")
                        .fontWeight(.semibold)
                        .font(.system(size: 24))
                        .foregroundColor(Color.blueAccent)
                    
                    TextField("", text: $viewModel.username, prompt: Text("Username")
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
                        viewModel.loginTapped.send()
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(RoundedRectangle(cornerRadius: 24).fill(Color.blueAccent))
                                .padding(.horizontal, 18)
                        } else {
                            Text("Login")
                                .fontWeight(.medium)
                                .font(.system(size: 16))
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .foregroundStyle(.white)
                                .background(RoundedRectangle(cornerRadius: 24).fill(Color.blueAccent))
                                .padding(.horizontal, 18)
                        }
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .foregroundStyle(.grayAccent)
                        
                        Button("Sign Up") {
                            dismiss()
                        }
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .foregroundStyle(.blueAccent)
                    }
                }
                
                NavigationLink(
                    destination: TabBarView(),
                    isActive: $viewModel.isLoginSuccess
                ) {
                    EmptyView()
                }
            }
            .background(.darkAccent)
        }
        .navigationBarHidden(true)
    }
}
