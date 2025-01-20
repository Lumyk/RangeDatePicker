//
//  CalendarService.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import Foundation

class CalendarService: ObservableObject {

    let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    /// Return week days symbols in localized order
    var weekDays: [String] {
        let firstWeekday = calendar.firstWeekday - 1 // -1 need because first day start from 1
        let weekdaySymbols = calendar.shortWeekdaySymbols
        return (0..<weekdaySymbols.count).map { index in
            // Normolize order for current locale
            let shiftedIndex = (index + firstWeekday) % weekdaySymbols.count
            return weekdaySymbols[shiftedIndex]
        }
    }

    /// Return days in month matrix. Spaces at the month start and end will be nil
    private func days(month: Int, year: Int) -> [[Day?]] {
        var components = DateComponents()
        components.month = month
        components.year = year

        guard let date = calendar.date(from: components) else { return [] }
        guard let daysRange = calendar.range(of: .day, in: .month, for: date) else { return [] }
        guard let weeksInMonth = calendar.range(of: .weekOfMonth, in: .month, for: date)?.count else { return [] }
        guard let daysInWeek = calendar.range(of: .weekday, in: .weekOfMonth, for: date)?.count else { return [] }

        // Create days in month matrix. Set nil for all days
        let matrix: [[Day?]] = Array(
            repeating: Array(repeating: nil, count: daysInWeek),
            count: weeksInMonth
        )

        let firstWeekday = calendar.firstWeekday - 1 // -1 need because first day start from 1

        // Fill matrix with days (Spaces at the month start and end will be nil)
        let days = daysRange.reduce(into: matrix) { matrix, day in
            components.day = day
            guard let date = calendar.date(from: components) else { return }
            let dayInWeek = calendar.component(.weekday, from: date) - 1 // -1 need because first day start from 1
            // Normolize order for current locale
            let shiftedDayInWeek = (dayInWeek - firstWeekday + daysInWeek) % daysInWeek
            let weekInMonth = calendar.component(.weekOfMonth, from: date) - 1 // -1 need because first week start from 1

            matrix[weekInMonth][shiftedDayInWeek] = .init(
                date: date,
                isToday: calendar.isDateInToday(date),
                isFirstInWeek: shiftedDayInWeek == 0,
                isLastInWeek: shiftedDayInWeek == daysInWeek - 1,
                isFirstInMonth: day == 1,
                isLastInMonth: day == daysRange.count
            )
        }

        return days
    }

    func months(monthsRange: ClosedRange<Int> = -12...12) -> [Month] {
        let months = Array(monthsRange).compactMap {
            calendar.date(byAdding: .month, value: $0, to: .now)
        }

        return months.map {
            let month = calendar.component(.month, from: $0)
            let year = calendar.component(.year, from: $0)

            return .init(
                date: $0,
                month: month,
                year: year,
                days: days(month: month, year: year)
            )
        }
    }

    func isSame(day: Day, as selected: Date?) -> Bool {
        selected.map { calendar.isDate(day.date, inSameDayAs: $0) } ?? false
    }

    func isInRange(day: Day, startDate: Date?, endDate: Date?) -> Bool {
        guard let startDate, let endDate else {
            return false
        }
        return day.date >= startDate && day.date <= endDate
    }

    func isCurrent(_ month: Month) -> Bool {
        let currentYear = calendar.component(.year, from: .now)
        let currentMonth = calendar.component(.month, from: .now)

        return month.year == currentYear && month.month == currentMonth
    }
}
