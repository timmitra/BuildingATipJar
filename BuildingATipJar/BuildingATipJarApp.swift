//
//  BuildingATipJarApp.swift
//  BuildingATipJar
//
//  Created by Tim Mitra on 2024-03-08.
//

import SwiftUI

@main


struct BuildingATipJarApp: App {
  
  @StateObject private var store = TipStore()
 
  var body: some Scene {
        WindowGroup {
            HomeView()
        }.environmentObject(store)
    }
}
