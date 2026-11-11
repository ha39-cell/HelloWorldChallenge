//
//  JournalEditorView.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 11/11/2026.
//

import SwiftUI

struct JournalEditorView: View {
    @State var title = ""
    @State var content = ""
    var body: some View {
        
        NavigationStack {
            
        VStack(alignment: .leading) {
            TextField("Title", text: $title)
                .font(Theme.Fonts.headingL)
            Text(Date().formatted(date: .numeric, time: .omitted))
                .font(Theme.Fonts.captionS)
                .foregroundStyle(Theme.Colors.textSecondary)
            TextField("Type your Journal...", text: $content, axis: .vertical)
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {

                } label: {
                    Image(systemName: Theme.Icons.close)
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {

                } label: {
                    Image(systemName: Theme.Icons.check)
                }
                .buttonStyle(.glassProminent)
                .tint(Theme.Colors.accent)
            }
        }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    JournalEditorView()
}
