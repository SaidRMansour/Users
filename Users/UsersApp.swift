//
//  UsersApp.swift
//  Users
//
//  Created by Alaa Trabulsi on 26/09/2022.
//

import SwiftUI
@main
struct UsersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel())
        }
    }
}
