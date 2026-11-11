//
//  Theme.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 10/11/2026.
//
import SwiftUI

enum Theme {

    // MARK: - 01 Colors
    enum Colors {
        static let accent          = Color(hex: 0x7F81FF) // Save button, active actions
        static let textAccent      = Color(hex: 0xAF99FD) // Journal titles, empty-state heading
        static let textPrimary     = Color(hex: 0xFFFFFF) // Main headings, journal content
        static let textSecondary   = Color(hex: 0xA39A9A) // Entry dates
        static let surface         = Color(hex: 0x1C1C1E) // Journal cards
        static let backgroundColor      = Color(hex: 0x000000) // Main screen background
        static let destructive     = Color(hex: 0xFD453C) // Delete action
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
