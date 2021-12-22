//
//  TMI_SwiftUIApp.swift
//  TMI-SwiftUI
//
//  Created by Jason on 2021/12/16.
//

import SwiftUI

@main
struct TMI_SwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
