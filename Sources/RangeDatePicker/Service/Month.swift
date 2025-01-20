//
//  Month.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import Foundation

struct Month: Identifiable, Hashable {
    let date: Date
    let month: Int
    let year: Int
    let days: [[Day?]]

    var id: String { "\(month)-\(year)" }
}
