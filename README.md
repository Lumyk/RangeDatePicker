# RangeDatePicker

**RangeDatePicker** is a SwiftUI component that enables users to select a date range by months through a clean and intuitive calendar interface. It's customizable and perfect for booking systems, subscriptions, reports, and other month-based date selection use cases.

Suppotrs iOS 15.0+

![Demo](Demo/Demo.gif?raw=true)

## Features

- **Month-Based Selection**: Easily pick start and end dates by months.
- **Customizable Range**: Configure the range of months relative to the current date.
- **Flexible Styling**: Adjust styles to match your app's design.
- **SwiftUI Native**: Built entirely with SwiftUI for seamless integration.

## Installation

Installation via Swift Package Manager:

```url
https://github.com/Lumyk/RangeDatePicker.git
```

## Usage

Here’s how you can use the `RangeDatePicker` in your SwiftUI project:

```swift
import SwiftUI
import RangeDatePicker

struct ContentView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil

    var body: some View {
        RangeDatePicker(
            startDate: $startDate,
            endDate: $endDate,
            monthsRange: -12...12,
            calendar: .current,
            style: .default
        )
    }
}
```

### Parameters

| Parameter     | Type                 | Default         | Description                                                                            |
|---------------|----------------------|-----------------|----------------------------------------------------------------------------------------|
| `startDate`   | `Binding<Date?>`     | Required        | A binding to the optional starting date of the selected range.                        |
| `endDate`     | `Binding<Date?>`     | Required        | A binding to the optional ending date of the selected range.                          |
| `monthsRange` | `ClosedRange<Int>`   | `-12...12`      | The range of months relative to the current date that defines the selectable range.   |
| `calendar`    | `Calendar`           | `.current`      | The calendar used for date calculations.                                              |
| `style`       | `RangeDatePickerStyle` | `.default`      | Custom styling configuration for the picker.                                          |

## Styling with RangeDatePickerStyle

The RangeDatePickerStyle class allows you to customize the appearance and behavior of the date picker. You can adjust colors, fonts, and date formatting to fit your app’s design.

## Usage

Here’s an example of using a custom style for the `RangeDatePicker`:
```swift
RangeDatePicker(
    startDate: $startDate,
    endDate: $endDate,
    style: .init(
        circleColor: .yellow,
        fillColor: .yellow.opacity(0.2),
        fillCornerRadius: 20,
        selectedDayColor: .black,
        currentDayColor: .brown,
        dayFont: .headline,
        currentDayFont: .headline.bold(),
        monthFont: .title2.bold()
    )
)
```

### Style Properties

| Parameter          | Type                 | Default                              | Description                                                                 |
|--------------------|----------------------|--------------------------------------|-----------------------------------------------------------------------------|
| `monthFormat`      | `(Date) -> String`  | `{ $0.formatted(.dateTime.month(.wide).year()) }` | A closure to format the displayed month.                                   |
| `dayFormat`        | `(Date) -> String`  | `{ $0.formatted(.dateTime.day()) }`  | A closure to format the displayed day.                                     |
| `circleColor`      | `Color`             | `.accentColor`                       | The color of the selection circle.                                         |
| `fillColor`        | `Color`             | `.accentColor.opacity(0.3)`          | The background fill color for the selected date range.                     |
| `fillCornerRadius` | `CGFloat`           | `4`                                  | The corner radius for the background fill.                                 |
| `circlePadding`    | `CGFloat`           | `10`                                 | The padding around the selection circle.                                   |
| `dayColor`         | `Color`             | `.primary`                           | The color of unselected days.                                              |
| `selectedDayColor` | `Color`             | `.white`                             | The color of selected days.                                                |
| `currentDayColor`  | `Color`             | `.red`                               | The color of the current day (today).                                      |
| `dayFont`          | `Font`              | `.body`                              | The font for days.                                                         |
| `currentDayFont`   | `Font`              | `.body.bold()`                       | The font for the current day.                                              |
| `monthColor`       | `Color`             | `.primary`                           | The color for month names.                                                 |
| `monthFont`        | `Font`              | `.title3.bold()`                     | The font for month names.                                                  |

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
