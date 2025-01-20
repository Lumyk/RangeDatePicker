//
//  RangeDatePickerStyle.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import SwiftUI

/// A customizable style for the `RangeDatePicker` component.
///
/// Use this class to define the visual appearance and behavior of the date picker,
/// including colors, fonts, and formatting for months and days.
public class RangeDatePickerStyle: ObservableObject {

    /// A closure to format the displayed month. Defaults to wide month and year format.
    public var monthFormat: (Date) -> String

    /// A closure to format the displayed day. Defaults to numeric day format.
    public var dayFormat: (Date) -> String

    /// The color of the selection circle around the day.
    public var circleColor: Color

    /// The background fill color for the selected date range.
    public var fillColor: Color

    /// A gradient used for fade effects in the fill end. Defaults to a gradient from clear to `fillColor`.
    public var fadeGradient: Gradient

    /// The corner radius for the background fill.
    public var fillCornerRadius: CGFloat

    /// The padding around the selection circle.
    public var circlePadding: CGFloat

    /// The color of unselected days.
    public var dayColor: Color

    /// The color of selected days.
    public var selectedDayColor: Color

    /// The color of the current day (today).
    public var currentDayColor: Color

    /// The font for days.
    public var dayFont: Font

    /// The font for the current day (today).
    public var currentDayFont: Font

    /// The color for month names.
    public var monthColor: Color

    /// The font for month names.
    public var monthFont: Font

    /// Initializes a new instance of `RangeDatePickerStyle` with customizable properties.
    ///
    /// - Parameters:
    ///   - monthFormat: A closure to format the month text. Defaults to wide month and year format.
    ///   - dayFormat: A closure to format the day text. Defaults to numeric day format.
    ///   - circleColor: The color of the selection circle. Defaults to `.accentColor`.
    ///   - fillColor: The background fill color for the date range. Defaults to `.accentColor.opacity(0.3)`.
    ///   - fadeGradient: A gradient used for fade effects in the fill end. Defaults to a gradient from clear to `fillColor`, default if nil.
    ///   - fillCornerRadius: The corner radius for the background fill. Defaults to `4`.
    ///   - circlePadding: The padding around the selection circle. Defaults to `10`.
    ///   - dayColor: The color of unselected days. Defaults to `.primary`.
    ///   - selectedDayColor: The color of selected days. Defaults to `.white`.
    ///   - currentDayColor: The color of the current day (today). Defaults to `.red`.
    ///   - dayFont: The font for days. Defaults to `.body`.
    ///   - currentDayFont: The font for the current day. Defaults to `.body.bold()`.
    ///   - monthColor: The color for month names. Defaults to `.primary`.
    ///   - monthFont: The font for month names. Defaults to `.title3.bold()`.
    public init(
        monthFormat: @escaping (Date) -> String = { $0.formatted(.dateTime.month(.wide).year()) },
        dayFormat: @escaping (Date) -> String = { $0.formatted(.dateTime.day()) },
        circleColor: Color = .accentColor,
        fillColor: Color = .accentColor.opacity(0.3),
        fadeGradient: Gradient? = nil,
        fillCornerRadius: CGFloat = 4,
        circlePadding: CGFloat = 10,
        dayColor: Color = .primary,
        selectedDayColor: Color = .white,
        currentDayColor: Color = .red,
        dayFont: Font = .body,
        currentDayFont: Font = .body.bold(),
        monthColor: Color = .primary,
        monthFont: Font = .title3.bold()
    ) {
        self.monthFormat = monthFormat
        self.dayFormat = dayFormat
        self.circleColor = circleColor
        self.fillColor = fillColor
        self.fillCornerRadius = fillCornerRadius
        self.circlePadding = circlePadding
        self.dayColor = dayColor
        self.selectedDayColor = selectedDayColor
        self.currentDayColor = currentDayColor
        self.dayFont = dayFont
        self.currentDayFont = currentDayFont
        self.monthColor = monthColor
        self.monthFont = monthFont
        self.fadeGradient = fadeGradient ?? Gradient(colors: [.clear, fillColor])
    }

    /// A default instance of `RangeDatePickerStyle` with predefined settings.
    public static var `default`: RangeDatePickerStyle { .init() }
}
