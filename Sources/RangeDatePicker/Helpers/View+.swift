//
//  View+.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
