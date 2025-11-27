//  ExtensionForView.swift

import SwiftUI

extension View {
    func printAllFonts() {
        for family in UIFont.familyNames.sorted() {
            print("🔤 Семейство: \(family)")
            
            for fontName in UIFont.fontNames(forFamilyName: family).sorted() {
                print("   📝 Шрифт: \(fontName)")
            }
            print("---")
        }
    }
}
