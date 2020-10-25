//
//  main.swift
//  Flappifier 1000
//
//  Created by Addison Hanrattie on 10/24/17.
//  Copyright © 2017 Addison Hanrattie. All rights reserved.
//

import Foundation
import Carbon.HIToolbox

var selectedCourse = ""
var holeNumber = 0



func input() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    var str = NSString(data: inputData, encoding: String.Encoding.utf8.rawValue)! as String
    str.removeLast()
    return str
}

func leftFlap(){
    let eventSource = CGEventSource(stateID: .hidSystemState)
    let keyDownEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: 3, keyDown: true)//123
    let keyUpEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: 3, keyDown: false)
    
    keyDownEvent?.post(tap: .cghidEventTap)
    keyUpEvent?.post(tap: .cghidEventTap)
}

func resetFlap(){
    let eventSource = CGEventSource(stateID: .hidSystemState)
    
    let keyDownEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: 15, keyDown: true)
    let keyUpEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: 15, keyDown: false)
    
    keyDownEvent?.post(tap: .cghidEventTap)
    keyUpEvent?.post(tap: .cghidEventTap)
//    }
}

func rightFlap(){
    let eventSource = CGEventSource(stateID: .hidSystemState)
    let keyDownEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: 40, keyDown: true)//124
    let keyUpEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: 40, keyDown: false)
    
    keyDownEvent?.post(tap: .cghidEventTap)
    keyUpEvent?.post(tap: .cghidEventTap)
}

print("Please drag in property list url")

var format = PropertyListSerialization.PropertyListFormat.xml
var plistData:[String:AnyObject] = [:]
let plistPath = input()
//print(input())
//print(FileManager.default.changeCurrentDirectoryPath("/"))
//print(plistPath?.absoluteString ?? "Probleum with getting absolute str from file path")

//let path = Bundle.main.path(forResource: "Holes", ofType: "plist")
let plistXML = FileManager.default.contents(atPath: plistPath)
print(plistXML!)
do {
    plistData = try PropertyListSerialization.propertyList(from: plistXML!, options: .mutableContainersAndLeaves, format: &format) as! [String:AnyObject]
    
} catch {
    print("Error reading plist: \(error), format: \(format)")
    fatalError("Could not read property list")
}

print("Please Select Your Course")

selectedCourse = input()

print("Please Select Hole #")

holeNumber = (Int(input()) ?? 0)
print("Searching For Course & Hole # and starting program")
sleep(3)
let courseData: NSArray = plistData[selectedCourse] as! NSArray
let holeData: NSArray = courseData[holeNumber - 1] as! NSArray
let group = DispatchGroup()
resetFlap()
for i in 0..<holeData.count {
//    print(i)
    group.enter()
    let queue = DispatchQueue(label: "\(i)Anrattie", qos: DispatchQoS.userInitiated, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: DispatchQueue.global())// fails because it wont take decimals.
    queue.asyncAfter(deadline: .now() + Double(exactly: (holeData[i] as! Double).magnitude)!, execute: {
        if abs(holeData[i] as! Double) == holeData[i] as! Double {
            rightFlap()
        } else {
            leftFlap()//last flap failing
        }
        group.leave()
        print(i)
    })
//    print(i, "done")
}
group.wait()
print("")







//switch selectedCourse {
//case "Golf Land":
//    let courseData: NSArray = plistData[selectedCourse] as! NSArray
//    switch holeNumber {
//    case 1:
//        let holeData: NSArray = courseData[0] as! NSArray
//        let group = DispatchGroup()
//        resetFlap()
//        for i in 1...(holeData[0] as! Int) {
//            print(i)
//            group.enter()
//            let queue = DispatchQueue(label: "\(i)Anrattie", qos: DispatchQoS.userInitiated, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.never, target: DispatchQueue.global())// fails because it wont take decimals.
//            queue.asyncAfter(deadline: .now() + Double(exactly: (holeData[i] as! Double).magnitude)!, execute: {
//                if abs(holeData[i] as! Double) == holeData[i] as! Double {
//                    rightFlap()
//                } else {
//                    leftFlap()//last flap failing
//                }
//                group.leave()
//                print("Elephant")
//            })
//            print(i, "done")
//        }
//        group.wait()
//        //Convert times to clicks
//        break
//    case 2: break
//    case 3: break
//    case 4: break
//    case 5: break
//    case 6: break
//    case 7: break
//    case 8: break
//    case 9: break
//    default:
//        print("Invalid Hole")
//        fatalError("Invalid Hole ID")
//    }
//default:
//    print("Invalid Course")
//    fatalError("Invalid Course ID")
//}

