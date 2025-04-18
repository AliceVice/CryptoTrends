//
//  LaunchView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 13/03/2025.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }
    @State private var showLoadingText: Bool = false
    
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launchTheme.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showLoadingText{
                    
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.launchTheme.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                if counter == loadingText.count - 1 {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
