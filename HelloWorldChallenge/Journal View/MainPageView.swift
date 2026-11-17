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
    // for the delete alert
    @State var showDeleteAlert = false
    @State var journalToDelete: JournalEntry?
    //bookmark filter activation 
    @State var sortByBookmark = false
    //  for search bar
    @State var searchText = ""
    //journal i tap to edit
    @State var journalToEdit: JournalEntry?
    // the list after sorting
    var sortedJournals: [JournalEntry] {
        if sortByBookmark {
            return viewModel.journals.sorted { $0.isBookmarked && !$1.isBookmarked }
        } else {
            return viewModel.journals.sorted { $0.date > $1.date }
        }
    }
    // the list after searching
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
            //empty state
            Group {
                if viewModel.journals.isEmpty {
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
                    // journal state
                } else {
                    // bookmark activation
                    List(filteredJournals) { journal in
                        JournalCardView(entry: journal, onBookmarkTap: {
                            viewModel.toggleBookmark(journal)
                        })
                       //tab card to edit it
                        .onTapGesture {
                            journalToEdit = journal                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                        
                        
                        // delete action connected to view model
                            .swipeActions {
                                        Button(role: .destructive) {
                                            journalToDelete = journal
                                            showDeleteAlert = true
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                    }
                    
                  
                    // Hide the default gray list background and use the app background
                    .scrollContentBackground(.hidden)
                    .background(Theme.Colors.backgroundColor)
                    
                }
                
                
                
            }
            
            .navigationTitle("Journal")
            .toolbarTitleDisplayMode(.inlineLarge)
            
            //typed letters goes into searchbar
            .searchable(text: $searchText, prompt: "Search")
            //searchable
            .searchPresentationToolbarBehavior(.avoidHidingContent)
            //voice icon in searchbar
//            .searchDictationBehavior(.inline(activation: .onSelect))
            
            .toolbar {
                Menu {
                    //activate the filter part3
                    Button("Sort by Bookmark") { sortByBookmark = true }
                       Button("Sort by Entry Date") { sortByBookmark = false }
                } label: {
                    Image(systemName: Theme.Icons.filter)
                }
                
                Button {
                    showEditor = true
                } label: {
                    Image(systemName: Theme.Icons.add)
                    
                    
                    
                    
                }
            }
            // this wont work without its own model
            .sheet(isPresented: $showEditor) {
                JournalEditorView(viewModel: viewModel)
            }
            
            // open the editor to edit a journal
            .sheet(item: $journalToEdit) { journal in
                JournalEditorView(viewModel: viewModel, journalToEdit: journal)
            }
            //show the alert
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
