

import SwiftUI

struct JournalEditorView: View {

    //to save the journal
    @ObservedObject var viewModel: JournalViewModel
    //edit journal 2
    var journalToEdit: JournalEntry? = nil

    @State var title = ""
    @State var content = ""
    // to open the keyboard on the title 1
    @FocusState var isTitleFocused: Bool
    // show the discard changes alert
    @State var showDiscardAlert = false
    // to close the page
    @Environment(\.dismiss) var dismiss

    // Checks whether the user has edited the title or content
    var hasChanges: Bool {
        title != (journalToEdit?.title ?? "") || content != (journalToEdit?.content ?? "")
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextField("Title", text: $title)
                    .font(Theme.Fonts.headingL)
                    // keyboard opened when type in Title
                    .focused($isTitleFocused)

                Text(Date().formatted(date: .numeric, time: .omitted))
                    .font(Theme.Fonts.captionS)
                    .foregroundStyle(Theme.Colors.textSecondary)

                TextField("Type your Journal...", text: $content, axis: .vertical)

                Spacer()
            }
            .padding()
            .onAppear {
                isTitleFocused = true
                // fill the old title and text if editing
                if let journal = journalToEdit {
                    title = journal.title
                    content = journal.content
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    //X action to close the screen
                    Button {
                        // Show the alert if there are unsaved changes, otherwise close
                        if hasChanges {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: Theme.Icons.close)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    //this will save the journal after clicking ✓ called from the viewModel
                    Button {
                        // update if editing, add if new
                        if let journal = journalToEdit {
                            viewModel.updateJournal(journal, title: title, content: content)
                        } else {
                            viewModel.addJournal(title: title, content: content)
                        }
                        dismiss()
                    } label: {
                        Image(systemName: Theme.Icons.check)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Theme.Colors.accent)
                    //couldn't save without title
                    .disabled(title.isEmpty)
                }
            }
            // Ask before discarding unsaved changes
            .alert("Are you sure you want to discard changes on this journal?", isPresented: $showDiscardAlert) {
                Button("Discard Changes", role: .destructive) {
                    dismiss()
                }
                Button("Keep Editing", role: .cancel) { }
            }
        }
    }
}

#Preview {
    JournalEditorView(viewModel: JournalViewModel())
}
