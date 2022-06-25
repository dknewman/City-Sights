//
//  City_SightsApp.swift
//  City Sights
//
//  Created by David Newman on 6/5/22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
            
        }
    }
}
