
import SwiftUI

struct JournalEditorView: View {
    
    //to save the journal
    @ObservedObject var viewModel: JournalViewModel
    @State var title = ""
    @State var content = ""
    
    // to close the page
    @Environment(\.dismiss) var dismiss                 // 👈 new: the close remote
    
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
                    //X action to close the screen
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: Theme.Icons.close)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    //this will save the journal after clicking ✓ called from the viewModel 
                    Button {
                viewModel.addJournal(title: title, content: content)
                        dismiss()
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
// triale to be delete it
#Preview {
    JournalEditorView(viewModel: JournalViewModel())
}
