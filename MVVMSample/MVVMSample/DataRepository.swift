//
//  DataRepository.swift
//  MVVMSample
//
//  Created by 樹佳 on 2023/04/04.
//

import Foundation
import Combine

protocol DataRepositoryProtocol {
    func saveData(value: Int)
    func fetchData() -> Int
}


class DataRepository: DataRepositoryProtocol {
    
    func saveData(value: Int) {
        UserDefaults.standard.setValue(value, forKey: "key")
    }
    
    func fetchData() -> Int {
        return UserDefaults.standard.integer(forKey: "key")
    }
    
}
