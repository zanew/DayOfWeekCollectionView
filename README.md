# ActiveDayCollectionView

![](https://github.com/zanew/DayOfWeekCollectionView/blob/master/weekpicker.gif)

A simple UI component for controlling which days of the week a thing is active on.

## Installation

### Swift Package Manager

In Xcode go to File -> Swift Packages -> Add Package Dependency and paste in the repo's url: https://github.com/zanew/ActiveDayCollectionView

## Usage

The control is backed by an `OptionSet`.

Example:
```swift
let activeDays = DaysOfWeekActive.weekdaysOnly
let weekCollectionView = ActiveDayCollectionView(activeDays: activeDays)
```
![](weekdays.png)

```swift
picker.activeDays = [.saturday, .sunday]
```
![](weekends.png)

### Styling
```
weekCollectionView.backgroundColor = .secondarySystemGroupedBackground
weekCollectionView.badgeSelectionColor = .systemOrange
```
![](style.png)

### SwiftUI
```
ActiveDayView(activeDays: $activeDays)
```



