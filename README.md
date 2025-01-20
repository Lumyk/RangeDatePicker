# RangeDatePicker

**RangeDatePicker** is a SwiftUI component that enables users to select a date range by months through a clean and intuitive calendar interface. It's customizable and perfect for booking systems, subscriptions, reports, and other month-based date selection use cases.

![Demo](https://link-to-your-demo.gif)

## Features

- **Month-Based Selection**: Easily pick start and end dates by months.
- **Customizable Range**: Configure the range of months relative to the current date.
- **Flexible Styling**: Adjust styles to match your app's design.
- **SwiftUI Native**: Built entirely with SwiftUI for seamless integration.

## Installation

1. Add the `RangeDatePicker` files to your project.
2. Import the module where needed:

   ```swift
   import RangeDatePicker

## Usage

Here’s how you can use the `RangeDatePicker` in your SwiftUI project:

```swift
import SwiftUI

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

### Parameters

| Parameter     | Type                 | Default         | Description                                                                            |
|---------------|----------------------|-----------------|----------------------------------------------------------------------------------------|
| `startDate`   | `Binding<Date?>`     | Required        | A binding to the optional starting date of the selected range.                        |
| `endDate`     | `Binding<Date?>`     | Required        | A binding to the optional ending date of the selected range.                          |
| `monthsRange` | `ClosedRange<Int>`   | `-12...12`      | The range of months relative to the current date that defines the selectable range.   |
| `calendar`    | `Calendar`           | `.current`      | The calendar used for date calculations.                                              |
| `style`       | `RangeDatePickerStyle` | `.default`      | Custom styling configuration for the picker.                                          |

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
