//
//  JournalEntry.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 09/11/2026.
//


import Foundation

struct JournalEntry: Identifiable {
let id = UUID()
var title: String
var content: String
var date: Date
var isBookmarked : Bool = false
}
