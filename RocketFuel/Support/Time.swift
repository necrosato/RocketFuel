//
//  Time.swift
//  RocketFuel
//
//  Created by Ardalan Samimi on 08/07/16.
//  Copyright © 2016 Ardalan Samimi. All rights reserved.
//
import Foundation
/**
 *  Convert seconds to a human readable time format.
 * 
 *  - Author: Ardalan Samimi
 */
struct Time {
  
  static fileprivate var secondsInHour: Double = 3600
  static fileprivate var secondsInMinute: Double = 60
  static fileprivate var unitsOfTime: [Double: String] = [3600: "hour", 60: "minute", 1: "second"]
  
  /**
   *  Converts seconds to a human readable time format.
   *
   *  - Parameter fromSeconds: The number of seconds.
   *
   *  - Returns: A string.
   */
  static func humanReadableTime(fromSeconds seconds: Double) -> String {
    var unit: Double = 1, time: [String] = []

    if seconds >= Time.secondsInHour {
      unit = Time.secondsInHour
    } else if seconds >= Time.secondsInMinute {
      unit = Time.secondsInMinute
    }
    // Get the proper time component and format it.
    let component = seconds / unit
    time.append(Time.format(component, unit: unit) ?? "")
    // A remainder means the there are more components. 
    if component.truncatingRemainder(dividingBy: 1) > 0 {
      let minorComponent = floor(((seconds / unit).truncatingRemainder(dividingBy: 1)) * unit)
      time.append(Time.humanReadableTime(fromSeconds: minorComponent))
    }
    
    return time.joined(separator: ", ")
  }
  /**
   *  Formats the time component.
   *
   *  - Parameters:
   *    - component: The time component.
   *    - unit: The unit of the time component.
   *
   *  - Returns: A string or nil.
   */
  fileprivate static func format(_ component: Double, unit: Double) -> String? {
    guard component > 0 else { return nil }
    var string = "\(Int(component)) \(Time.unitsOfTime[unit]!)"
    
    if Int(component) > 1 {
      string.append("s")
    }
    
    return string
  }
  
}
