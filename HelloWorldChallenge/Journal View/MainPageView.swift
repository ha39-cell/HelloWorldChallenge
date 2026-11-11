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
      
                    .preferredColorScheme(.dark)
            }
    }
    }
    
        }
    

#Preview {
    MainPageView()
    
}
