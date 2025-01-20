//
//  DayCell.swift
//  RangeDatePicker
//
//  Created by Yevhenii Kalashnikov on 20.01.2025.
//

import SwiftUI

struct DayCell: View {
    @EnvironmentObject var service: CalendarService
    @EnvironmentObject var style: RangeDatePickerStyle

    let day: Day
    let startDate: Date?
    let endDate: Date?
    let acrion: (Day) -> Void

    @State private var daySize: CGSize = .zero

    private var isSelectedStart: Bool {
        service.isSame(day: day, as: startDate)
    }

    private var isSelectedEnd: Bool {
        service.isSame(day: day, as: endDate)
    }

    private var isSelected: Bool {
        isSelectedStart || isSelectedEnd
    }

    private var isInRange: Bool {
        service.isInRange(day: day, startDate: startDate, endDate: endDate)
    }

    private var isFadeLeft: Bool {
        day.isFirstInMonth && !day.isFirstInWeek
    }

    private var isFadeRight: Bool {
        day.isLastInMonth && !day.isLastInWeek
    }

    private var cilcledCorners: UIRectCorner {
        if day.isFirstInWeek {
            return [.topLeft, .bottomLeft]
        } else if day.isLastInWeek {
            return [.topRight, .bottomRight]
        } else {
            return []
        }
    }

    private func fadeRectangle(left: Bool) -> some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: style.fadeGradient,
                startPoint: left ? .leading : .trailing,
                endPoint: left ? .trailing : .leading
            ))
            .padding(left ? .leading : .trailing, -daySize.width)
    }

    var body: some View {
        Text(style.dayFormat(day.date))
            .font(day.isToday ? style.currentDayFont : style.dayFont)
            .frame(maxWidth: .infinity)
            .foregroundColor(isSelected ? style.selectedDayColor : day.isToday ? style.currentDayColor : style.dayColor)
            .overlay {
                GeometryReader { geometry in
                    Color.clear.onAppear {
                        daySize = geometry.size
                    }
                }
            }
            .background {
                if isSelected {
                    Circle()
                        .fill(style.circleColor)
                        .padding(.all, -style.circlePadding)
                }
            }
            .background {
                if isInRange {
                    ZStack(content: {
                        if isFadeLeft, !isSelectedStart {
                            fadeRectangle(left: true)
                        } else if isFadeRight, !isSelectedEnd {
                            fadeRectangle(left: false)
                        } else {
                            RoundedCornerShape(corners: cilcledCorners, radius: style.fillCornerRadius)
                                .fill(style.fillColor)
                        }
                    })
                    .frame(height: daySize.height + style.circlePadding)
                    .if(isSelectedStart) {
                        $0.padding(.leading, daySize.width / 2)
                    }
                    .if(isSelectedEnd) {
                        $0.padding(.trailing, daySize.width / 2)
                    }
                }
            }
            .padding(.vertical, style.circlePadding)
            .contentShape(Rectangle())
            .onTapGesture {
                acrion(day)
            }
    }
}
