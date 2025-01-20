//
//  Preview.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import SwiftUI

#Preview {
    RangeDatePicker(
        startDate: .constant(.now.addingTimeInterval(24 * 60 * 60 * -10)),
        endDate: .constant(.now.addingTimeInterval(24 * 60 * 60 * 20))
    )
}
