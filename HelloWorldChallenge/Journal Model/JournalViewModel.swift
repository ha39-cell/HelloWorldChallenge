//
//  JournalViewModel.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 11/11/2026.
//


import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var journals: [JournalEntry] = []
}
    

//import SwiftUI
//import Combine
//
//class JournalViewModel: ObservableObject {
//    @Published var journals: [JournalEntry] = [
//        JournalEntry(title: "My Birthday", content: "Today was amazing!", date: Date(), isBookmarked: true),
//        JournalEntry(title: "Today's Journal", content: "I learned SwiftUI today.", date: Date()),
//        JournalEntry(title: "Great Day", content: "Went for a walk.", date: Date())
//    ]
//}
