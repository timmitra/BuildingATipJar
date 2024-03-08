//
//  ContentView.swift
//  BuildingATipJar
//
//  Created by Tim Mitra on 2024-03-08.
//

import SwiftUI

struct HomeView: View {
  @State private var showTips = false
  @StateObject private var store = TipStore()
      
      var body: some View {
          VStack {
              
              Button("Tip Me") {
                  showTips.toggle()
              }
              .tint(.blue)
              .buttonStyle(.bordered)

          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay {
              
              if showTips {
                  Color.black.opacity(0.8)
                      .ignoresSafeArea()
                      .transition(.opacity)
                      .onTapGesture {
                          showTips.toggle()
                          
                      }
                  TipsView {
                      showTips.toggle()
                  }
                  .environmentObject(store)
                  .transition(.move(edge: .bottom).combined(with: .opacity))
              }
          }
          .animation(.spring(), value: showTips)
      }
}

#Preview {
    HomeView()
}
