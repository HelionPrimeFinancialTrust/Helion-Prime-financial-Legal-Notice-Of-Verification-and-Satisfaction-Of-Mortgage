//
//  LegalDocGeneratorApp.swift
//  LegalDocGenerator
//
//  Created by Helion Prime Financial Trust
//  Copyright © 2026 Helion Prime Financial Trust. All rights reserved.
//

import SwiftUI

@main
struct LegalDocGeneratorApp: App {
    @StateObject private var documentManager = DocumentManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(documentManager)
        }
    }
}
