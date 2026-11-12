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
    
    func addJournal(title: String, content: String) {
        let newJournal = JournalEntry(title: title, content: content, date: Date())
        journals.insert(newJournal, at: 0)
    }
    
    func deleteJournal(_ journal: JournalEntry) {           journals.removeAll { item in item.id == journal.id }    }
}
    

