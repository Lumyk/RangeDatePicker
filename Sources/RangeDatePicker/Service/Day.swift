//
//  Day.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import Foundation

struct Day: Hashable {
    let date: Date

    let isToday: Bool
    let isFirstInWeek: Bool
    let isLastInWeek: Bool
    let isFirstInMonth: Bool
    let isLastInMonth: Bool
}
