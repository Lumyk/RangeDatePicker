//
//  RangeDatePicker.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import SwiftUI

/// RangeDatePicker is a SwiftUI component that allows users to select a date range by months through a simple and intuitive interface
///
/// Example:
/// ```swift
/// @State private var startDate: Date? = nil
/// @State private var endDate: Date? = nil
///
/// var body: some View {
///     RangeDatePicker(
///         startDate: $startDate,
///         endDate: $endDate,
///         monthsRange: -6...6,
///         calendar: .current,
///         style: .default
///     )
/// }
/// ```
///
public struct RangeDatePicker: View {

    @Binding public var startDate: Date?
    @Binding public var endDate: Date?

    private let monthsRange: ClosedRange<Int>
    private let service: CalendarService
    private let style: RangeDatePickerStyle

    @State private var months: [Month] = []

    /// Initializes a new instance of `RangeDatePicker`.
    ///
    /// - Parameters:
    ///   - startDate: A binding to the optional starting date of the selected range.
    ///   - endDate: A binding to the optional ending date of the selected range.
    ///   - monthsRange: A range of months relative to the current date that defines the selectable range in the calendar. Defaults to `-12...12`.
    ///   - calendar: The calendar to be used for date calculations. Defaults to `.current`.
    ///   - style: The style configuration for the range date picker. Defaults to `.default`.
    ///
    /// This initializer creates a date range picker, allowing users to select a start and end date within a specified range of months.
    /// It supports customization for calendar and styling.
    public init(startDate: Binding<Date?>,
                endDate: Binding<Date?>,
                monthsRange: ClosedRange<Int> = -12...12,
                calendar: Calendar = .current,
                style: RangeDatePickerStyle = .default) {

        _startDate = startDate
        _endDate = endDate
        self.monthsRange = monthsRange
        service = .init(calendar: calendar)
        self.style = style
    }

    public var body: some View {
        VStack {
            HStack {
                ForEach(service.weekDays, id: \.self) {
                    Text($0)
                        .font(.body)
                        .foregroundColor(.black.opacity(0.6))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 16)
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                        ForEach(months) {
                            MonthCell(
                                month: $0,
                                selectedStartDate: $startDate,
                                selectedEndDate: $endDate
                            )
                        }
                    }
                }
                .onAppear {
                    months = service.months(monthsRange: monthsRange)

                    // Searching for the month.
                    // If selected, scroll to the month of 'startDate'. Otherwise, scroll to the current month
                    guard let month = months.first(where: { service.isCurrent($0, date: startDate ?? .now) }) else {
                        return
                    }
                    // Need dalay to wait for all cells rendering
                    DispatchQueue.main.async {
                        proxy.scrollTo(month.id, anchor: .top)
                    }
                }
            }
            .environmentObject(service)
            .environmentObject(style)
        }
    }
}
