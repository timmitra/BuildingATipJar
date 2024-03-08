//
//  TipStore.swift
//  BuildingATipJar
//
//  Created by Tim Mitra on 2024-03-08.
//

import Foundation
import StoreKit

enum TipsError: Error {
  case failedVerification
}

typealias PurchaseResult = Product.PurchaseResult

final class TipStore: ObservableObject {
  
  @Published private(set) var items = [Product]()
  
  init() {
    Task { [weak self] in
      await self?.retrieveProducts()
    }
  }
  
  func purchase(_ item: Product) async {
    
    do {
      
      let result = try await item.purchase()
      
      try await handlePurchase(from: result)
      
    } catch {
      // TODO: Handle error
      print(error)
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
  
  func handlePurchase(from result: PurchaseResult) async throws {
    
    switch result {
      
    case .success(let verification):
      print("Purchase was a success, now it's time to verify their purchase.")
      
      // verify
      let transaction = try checkVerified(verification)
      
      // TODO: Verification was Ok, update UI
      
      await transaction.finish()
      
    case .pending:
      print("The user needs to complete some action on their account before they can complete the purchase.")
      
    case .userCancelled:
      print("The user hit cancel before their transaction started.")
      
    default:
      break
    }
  }
  
  func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
    
    switch result {
    case .unverified:
      print("The verification of the user failed.")
      throw TipsError.failedVerification
    case .verified(let safe):
      return safe
    }
  }
}
