//
//  MonthCell.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import SwiftUI

struct MonthCell: View {

    private struct Id: Hashable {
        let days: [[Day?]]
        let start: Date?
        let end: Date?
    }

    @EnvironmentObject var service: CalendarService
    @EnvironmentObject var style: RangeDatePickerStyle

    let month: Month
    @Binding var selectedStartDate: Date?
    @Binding var selectedEndDate: Date?

    var body: some View {
        Section {
            VStack(spacing: 0) {
                ForEach(month.days, id: \.self) { week in
                    HStack(spacing: 0) {
                        ForEach(week, id: \.self) { day in
                            if let day {
                                DayCell(day: day, startDate: selectedStartDate, endDate: selectedEndDate) { day in
                                    if selectedStartDate == nil {
                                        selectedStartDate = day.date
                                    } else if selectedEndDate == nil {
                                        if let start = selectedStartDate, start > day.date {
                                            selectedEndDate = selectedStartDate
                                            selectedStartDate = day.date
                                        } else {
                                            selectedEndDate = day.date
                                        }
                                    } else {
                                        selectedStartDate = day.date
                                        selectedEndDate = nil
                                    }
                                }
                            } else {
                                Color.clear
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
                // Added Id for reloading all months on selection
                .id(Id(days: month.days, start: selectedStartDate, end: selectedEndDate))
            }
            .padding(.horizontal, 16)
            Spacer(minLength: 30)
        } header: {
            VStack(alignment: .leading) {
                Text(style.monthFormat(month.date))
                    .font(style.monthFont)
                    .foregroundColor(.black.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
        }
        .id(month.id)
    }
}
