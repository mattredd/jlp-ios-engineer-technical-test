//
//  IStack.swift
//  Books
//
//  Created by Matthew Reddin on 04/01/2022.
//

import SwiftUI


// A stack that will vary between using an HStack or a VStack for the content depending on the vertical size class
struct IStack<Content: View>: View {
    
    @Environment(\.verticalSizeClass) var vSizeClass
    @ViewBuilder let content: () -> Content
    let spacing: CGFloat? = nil
    let alignment: VerticalAlignment = .center
    
    var body: some View {
        if vSizeClass != .compact {
            VStack(alignment: alignment == .top ? .leading : (alignment == .center ? .center : .trailing), spacing: spacing, content: content)
        } else {
            HStack(alignment: alignment, spacing: spacing, content: content)
        }
    }
}
