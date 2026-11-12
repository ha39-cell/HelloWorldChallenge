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
                    List(viewModel.journals) { journal in
                        JournalCardView(entry: journal)
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
                    
                    
                }
                
                
                
            }
            
            .navigationTitle("Journal")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                Menu {
                    Button("Sort by Bookmark") { }
                    Button("Sort by Entry Date") { }
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
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    MainPageView()
    
}
