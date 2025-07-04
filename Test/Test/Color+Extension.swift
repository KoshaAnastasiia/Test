import SwiftUI

extension Color {
    static func rgba(_ red: CGFloat,
                     _ green: CGFloat,
                     _ blue: CGFloat,
                     _ opacity: CGFloat = 1) -> Color {
        Color(red: red/255.0,
              green: green/255.0,
              blue: blue/255.0)
        .opacity(opacity)
    }
}

