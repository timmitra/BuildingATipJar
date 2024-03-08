//
//  TipStore.swift
//  BuildingATipJar
//
//  Created by Tim Mitra on 2024-03-08.
//

import Foundation
import StoreKit

final class TipStore: ObservableObject {
  
  @Published private(set) var items = [Product]()
  
  init() {
    Task { [weak self] in
      await self?.retrieveProducts()
    }
  }
}

private extension TipStore {
  
  @MainActor // views will listen, so we update on the main thread
  func retrieveProducts() async {
    do {
      let products = try await Product.products(for: myTipProductIdentifiers).sorted(by: { $0.price < $1.price })
      items = products // we just sorted by price
    } catch {
      // TODO: Handle Error
      print(error)
    }
  }
}
