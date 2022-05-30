//
//  ImageViewer.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import SwiftUI

struct ProductImageViewer: View {
    
    @EnvironmentObject var detailViewModel: ProductDetailViewModel
    
    var body: some View {
        TabView {
            ForEach(Array(detailViewModel.imagesURLs.indices), id: \.self) { index in
                ZStack {
                    switch detailViewModel.images[index] {
                    case .uninitialised:
                        Color(.systemBackground)
                            .onAppear {
                                Task {
                                    if index == 0 {
                                        // As there is an animation hiccup when the navigation transitions to this view; delay the loading of the first image until the animation is complete
                                        try? await Task.sleep(nanoseconds: 250_000_000)
                                    }
                                    await detailViewModel.fetchImage(index: index)
                                }
                            }
                    case .loading:
                        ProgressView()
                    case .loaded(let img):
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                    case .error:
                        Image(systemName: "slash.circle")
                            .font(.largeTitle)
                    }
                }
                .tag(detailViewModel.imagesURLs[index])
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}
