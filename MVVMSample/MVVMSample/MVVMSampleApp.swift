//
//  MVVMSampleApp.swift
//  MVVMSample
//
//  Created by 樹佳 on 2023/04/03.
//

import SwiftUI

@main
struct MVVMSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vModel: DataViewModel())
        }
    }
}
