//
//  MainPageView.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 11/11/2026.
//

import SwiftUI

struct MainPageView: View {

    @StateObject var viewModel = JournalViewModel()
    @State var showEditor = false

    // Delete alert state
    @State var showDeleteAlert = false
    @State var journalToDelete: JournalEntry?

    // Sort, search and edit state
    @State var sortByBookmark = false
    @State var searchText = ""
    @State var journalToEdit: JournalEntry?

    // Journals sorted by bookmark or by date
    var sortedJournals: [JournalEntry] {
        if sortByBookmark {
            return viewModel.journals.sorted { $0.isBookmarked && !$1.isBookmarked }
        } else {
            return viewModel.journals.sorted { $0.date > $1.date }
        }
    }

    // Sorted journals filtered by the search text
    var filteredJournals: [JournalEntry] {
        if searchText.isEmpty {
            return sortedJournals
        } else {
            return sortedJournals.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.journals.isEmpty {
                    // Empty state
                    ContentUnavailableView {
                        Label {
                            Text("Begin Your Journal")
                                .font(Theme.Fonts.titleCard)
                                .foregroundStyle(Theme.Colors.textAccent)
                        } icon: {
                            Theme.Images.illustration
                                .resizable()
                                .scaledToFit()
                                .frame(width: 151)
                        }
                    } description: {
                        Text("Craft your personal diary, tap the plus icon to begin")
                            .font(Theme.Fonts.captionM)
                            .foregroundStyle(Theme.Colors.textPrimary)
                    }
                } else {
                    // Journals list
                    List(filteredJournals) { journal in
                        JournalCardView(entry: journal, onBookmarkTap: {
                            viewModel.toggleBookmark(journal)
                        })
                        // Tap a card to edit it
                        .onTapGesture {
                            journalToEdit = journal
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                        // Swipe to delete
                        .swipeActions {
                            Button(role: .destructive) {
                                journalToDelete = journal
                                showDeleteAlert = true
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    // Hide the default list background
                    .scrollContentBackground(.hidden)
                    .background(Theme.Colors.backgroundColor)
                }
            }
            .navigationTitle("Journal")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(text: $searchText, prompt: "Search")
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            .toolbar {
                // Sort menu
                Menu {
                    Button("Sort by Bookmark") { sortByBookmark = true }
                    Button("Sort by Entry Date") { sortByBookmark = false }
                } label: {
                    Image(systemName: Theme.Icons.filter)
                }

                // Add button
                Button {
                    showEditor = true
                } label: {
                    Image(systemName: Theme.Icons.add)
                }
            }
            // Editor for a new journal
            .sheet(isPresented: $showEditor) {
                JournalEditorView(viewModel: viewModel)
            }
            // Editor for an existing journal
            .sheet(item: $journalToEdit) { journal in
                JournalEditorView(viewModel: viewModel, journalToEdit: journal)
            }
            // Delete confirmation
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let journal = journalToDelete {
                        viewModel.deleteJournal(journal)
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
    }
}

#Preview {
    MainPageView()
}
