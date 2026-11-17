//
//  JournalCard.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 09/11/2026.
//
import SwiftUI

struct JournalCardView: View {
    var entry: JournalEntry
    // bookmark function
    var onBookmarkTap: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                //Title
                Text(entry.title)
                    .foregroundStyle(Theme.Colors.textAccent)
                    .font(Theme.Fonts.titleCard)

                Spacer()

                //Bookmark
                Button {
                    onBookmarkTap()
                } label: {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Theme.Colors.textAccent)
                }
                .buttonStyle(.plain)
            }

            //date
            Text(entry.date.formatted(date: .numeric, time: .omitted))
                .foregroundStyle(Theme.Colors.textSecondary)
                .font(Theme.Fonts.captionS)
                .padding(.bottom, 12)

            //text
            Text(entry.content)
                .foregroundStyle(Theme.Colors.textPrimary)
                .font(Theme.Fonts.bodyM)
        }
        .padding()
        .background(Theme.Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    JournalCardView(entry: JournalEntry(title: "My Birthday", content: "Today was a special day.", date: Date()))
        .padding()
}
