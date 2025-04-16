//
//  ContentView.swift
//  ssugssug
//
//  Created by Apple on 4/9/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            MainView(viewModel: authViewModel)
        } else {
            LoginView(viewModel: authViewModel)
        }
    }
}

#Preview {
    ContentView()
}
