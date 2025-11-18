//
//  StoriesFeed.swift
//  Trains
//
//  Created by Владимир on 18.11.2025.
//
import SwiftUI

struct StoriesFeed: View {
    let imageViewArray = ["1","2","3","4","5"]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(imageViewArray, id: \.self) { imageName in
                    Stories(imageName: imageName)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 160)
        .scrollIndicators(.hidden)
    }
}
