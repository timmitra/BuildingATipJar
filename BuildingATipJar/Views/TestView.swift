//
//  TestView.swift
//  BuildingATipJar
//
//  Created by Tim Mitra on 2024-03-08.
//

import SwiftUI
import StoreKit

struct TestView: View {
  
  @State private var myProduct: Product?
  
    var body: some View {
      VStack {
        Text("Product Info")
        Text(myProduct?.displayName ?? "")
        Text(myProduct?.description ?? "")
        Text(myProduct?.displayPrice ?? "")
      }
      .task {
        myProduct = try? await Product.products(for: ["ITG.BuildingATipJar.tinyTip"]).first
      }
    }
}

#Preview {
    TestView()
}
