//
//  JournalViewModel.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 11/11/2026.
//


import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var journals: [JournalEntry] = [] {
        //save call to call save function
        didSet {
            save()  }
        
            }
    //Load call when app opens
    init() {
        load()
    }
    
        // Add funtion
    func addJournal(title: String, content: String) {
        let newJournal = JournalEntry(title: title, content: content, date: Date())
        journals.insert(newJournal, at: 0)
    }
    //Delete funtion
    func deleteJournal(_ journal: JournalEntry) {           journals.removeAll { item in item.id == journal.id }    }
    
    //Save function
    func save() {
        if let data = try? JSONEncoder().encode(journals) {
            UserDefaults.standard.set(data, forKey: "journals")
        }
    }
  
 
    //Load function
    func load() {
        if let data = UserDefaults.standard.data(forKey: "journals"),
           let saved = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            journals = saved
        }
    }
    
    
    
}

    

