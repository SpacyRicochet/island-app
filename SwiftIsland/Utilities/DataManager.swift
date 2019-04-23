//
//  DataManager.swift
//  SwiftIsland
//
//  Created by Paul Peelen on 2019-04-20.
//  Copyright © 2019 AppTrix AB. All rights reserved.
//

import Foundation

protocol DataManaging {
  func getSchedule(completion: @escaping (Result<[Schedule], DataErrors>) -> Void)
  func getArea(completion: @escaping (Result<[Area], DataErrors>) -> Void)
}

enum DataErrors: Error {
  case noData
}

class DataManager {

  static let shared = DataManager()
  private let cacheManager: CacheManaging

  init(cacheManager: CacheManaging = CacheManager()) {
    self.cacheManager = cacheManager
  }
}

extension DataManager: DataManaging {

  func getSchedule(completion: @escaping (Result<[Schedule], DataErrors>) -> Void) {
    do {
      let schedule: [Schedule] = try cacheManager.get(from: .schedule)
      completion(.success(schedule))
    } catch {
      debugPrint("Some error: \(error.localizedDescription)")
      completion(.failure(.noData))
    }
  }

  func getArea(completion: @escaping (Result<[Area], DataErrors>) -> Void) {
    do {
      let area: [Area] = try cacheManager.get(from: .area)
      completion(.success(area))
    } catch {
      debugPrint("Some error: \(error.localizedDescription)")
      completion(.failure(.noData))
    }
  }
}
