import SwiftUI

enum Theme {

    // MARK: - 01 Colors
    enum Colors {
        //main purple
        static let accent = Color("PrimaryAccent")
        //light purple
        static let textAccent = Color("TextAccent")
        
        // Main headings, journal content (black in light, white in dark)
        static let textPrimary = Color.primary
        // Entry dates (adapts to light and dark)
        static let textSecondary = Color.secondary
        // Journal cards (adapts to light and dark)
        static let surface = Color(uiColor: .secondarySystemBackground)
        // Main screen background (white in light, black in dark)
        static let backgroundColor = Color(uiColor: .systemBackground)
        // Delete action
        static let destructive = Color.red
    }

    // MARK: - 02 Typography (SF Pro = the system font)
    enum Fonts {
        static let display        = Font.system(size: 42, weight: .black)
        static let headingL       = Font.system(size: 34, weight: .bold)
        static let headingM       = Font.system(size: 24, weight: .bold)
        static let titleCard      = Font.system(size: 24, weight: .semibold)
        static let bodyL          = Font.system(size: 20, weight: .regular)
        static let bodyM          = Font.system(size: 18, weight: .regular)
        static let bodySupporting = Font.system(size: 18, weight: .light)
        static let captionM       = Font.system(size: 16, weight: .regular)
        static let captionS       = Font.system(size: 14, weight: .regular)
    }

    // MARK: - 03 Assets
    // Icons (SF Symbols)
    enum Icons {
        static let close      = "xmark"
        static let bookmark   = "bookmark"
        static let bookmarked = "bookmark.fill"
        static let delete     = "trash.fill"
        static let check      = "checkmark"
        static let add        = "plus"
        static let filter     = "line.3.horizontal.decrease"
    }

    // Pictures (in media)
    enum Images {
        static let appIcon      = Image("appIcon")
        static let illustration = Image("illustration")
    }
}

// MARK: - Hex helper
extension Color {
    init(hex: UInt) {
        self.init(
            red:   Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8)  & 0xFF) / 255,
            blue:  Double(hex & 0xFF) / 255
        )
    }
}
