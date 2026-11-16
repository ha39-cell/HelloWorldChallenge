//
//  Splash.swift
//  HelloWorldChallenge
//
//  Created by Haneen  on 11/11/2026.
//
import SwiftUI

struct Splash: View {
    @State var showMainPage = false
    
    //UI
    var body: some View {
        if showMainPage {
            // called mainPageView
            MainPageView()
        } else {
            VStack(spacing: 12) {
                Theme.Images.illustration
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Text("Journali")
                    .font(Theme.Fonts.headingL)
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Text("Your thoughts, your story")
                    .font(Theme.Fonts.captionM)
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .task {
                //
                try? await Task.sleep(for: .seconds(2))
                withAnimation {
                    showMainPage = true
                }
            }
        }
    }
}

#Preview {
    Splash()
}
#Preview {
    Splash()
}
