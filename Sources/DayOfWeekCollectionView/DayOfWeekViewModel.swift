//
//  DayOfWeekViewModel.swift
//  Sol
//
//  Created by Zane Whitney on 3/10/20.
//  Copyright © 2020 Kitsch. All rights reserved.
//
import Foundation

// MARK: library
public struct DaysOfWeekActive: OptionSet {
    public let rawValue: UInt
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let sunday = DaysOfWeekActive(rawValue: 1 << 0)
    public static let monday = DaysOfWeekActive(rawValue: 1 << 1)
    public static let tuesday = DaysOfWeekActive(rawValue: 1 << 2)
    public static let wednesday = DaysOfWeekActive(rawValue: 1 << 3)
    public static let thursday = DaysOfWeekActive(rawValue: 1 << 4)
    public static let friday = DaysOfWeekActive(rawValue: 1 << 5)
    public static let saturday = DaysOfWeekActive(rawValue: 1 << 6)
    
    public static let weekdaysOnly: DaysOfWeekActive = [.monday, .tuesday, .wednesday, .thursday, .friday]
}

public class DayOfWeekViewModelBaseWrapper {
    public var weekdaySetting: DaysOfWeekActive
    
    public init(activeDays: DaysOfWeekActive) {
        self.weekdaySetting = activeDays
    }
    
    func dayOfWeekAbbreviated(forIndexPath indexPath: IndexPath) -> String {
        switch (indexPath.row) {
        case 0:
            return "S"
        case 1:
            return "M"
        case 2:
            return "T"
        case 3:
            return "W"
        case 4:
            return "T"
        case 5:
            return "F"
        case 6:
            return "S"
        default:
            return ""
        }
    }
    
    var numberOfItems: Int {
        return 7
    }
    
    func isDayOfWeekActive(atIndexPath indexPath: IndexPath) -> Bool {
        // if the 1s place bit is set, then the number will be odd
        return ((weekdaySetting.rawValue >> (indexPath.row)) % 2) == 1
    }
    
    func setDayOfWeekActive(state: Bool, forIndexPath indexPath: IndexPath) {
        let day = DaysOfWeekActive.init(rawValue: (1 << indexPath.row))
        
        if state {
            weekdaySetting.insert(day)
            print("Weekday Setting \(weekdaySetting)")
        } else {
            weekdaySetting.remove(day)
            print("Weekday Setting \(weekdaySetting)")
        }
    }
}

// MARK: library version
#if !FULL_WEEKDAY_PICKER
public class DayOfWeekViewModel: DayOfWeekViewModelBaseWrapper {
    func isDayOfWeekActive(dayOfWeek: DaysOfWeekActive) -> Bool {
        return weekdaySetting.contains(dayOfWeek)
    }
}
// MARK: personal support for themeing, etc. as part of https://github.com/zanew/HueCircadianSchedule
#else
public class DayOfWeekViewModel: DayOfWeekViewModelBaseWrapper, ThemeUpdating, NightLightResponding, PeriodicUpdateRegistering {
    var theme: Theme {
        didSet {
            updateTheme?(theme)
        }
    }
    
    var updateTheme: ((Theme?) -> Void)?
    
    public var nightlight: Setting<Bool>?
            
    public required init(withActiveDays activeDays: DaysOfWeekActive, nightLightSetting nightlight: Setting<Bool>) {
        self.nightlight = nightlight
        theme = nightlight.valueDescriptor ?? false ? .nightLight : SolarTime.theme(forSolarTime: CircadianManager.sharedInstance.solarTime)
        super.init(activeDays: activeDays)
    }
    
    func registerUpdaters() {
        registerForSolarTimeUpdates()
    }
}
#endif


