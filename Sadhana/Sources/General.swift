//
//  General.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 6/26/17.
//  Copyright © 2017 Alexander Koryttsev. All rights reserved.
//

import UIKit
import AlamofireImage
import Fabric
import Crashlytics

@_exported import RxSwift

struct Config {
    #if DEV
        static let host = "dev.vaishnavaseva.net"
    #else
        static let host = "vaishnavaseva.net"
    #endif

    #if DEBUG
        static let defaultLogin = "test@test.com"
        static let defaultPassword = "1"
    #else
        static let defaultLogin = ""
        static let defaultPassword = ""
    #endif
}

typealias JSON = [String: Any]
typealias JSONArray = [JSON]
typealias Block = () -> Void


enum GeneralError : Error {
    case error
    case noSelf
}

let Device = UIDevice.current
let iOS = NSString(string: Device.systemVersion).integerValue
let Screen = UIScreen.main
let ScreenSize = Screen.bounds.size
let ScreenWidth = ScreenSize.width
let ScreenHeight = ScreenSize.height
let iPhone = UI_USER_INTERFACE_IDIOM() == .phone
let iPhoneX = max(ScreenWidth, ScreenHeight) == 812.0
let iPad = UI_USER_INTERFACE_IDIOM() == .pad
let TopInset = CGFloat(iPhoneX ? 88 : 64)

enum NotificationName : String {
    case entriesDidSend

    var value : Notification.Name {
        return Notification.Name(rawValue)
    }
}

extension Notification.Name {
    static func local(_ name: NotificationName) -> Notification.Name {
        return name.value
    }
}

func iOS(_ version: Int) -> Bool {
    return iOS >= version
}

struct Local {
    static let service = LocalService{}
    static let defaults = LocalDefaults()
}

struct Main {
    static let service = MainService()
}

class Common {
    static let shared = Common()
    let calendar : Calendar
    private var dates = [[Date]]()

    init() {
        var cal = Calendar.current
        cal.timeZone = TimeZone.zero()
        calendar = cal
    }

    var calendarDates : [[Date]] {
        get {
            if dates.count == 0 || dates.first!.first! != Date().trimmedTime {
                dates.removeAll()
                var month = [Date]()
                var date = Date().trimmedTime
                var stop = false

                while !stop {
                    month.append(date)

                    if calendar.component(.day, from: date) == 1,
                        month.count > 0 {
                        dates.append(month)
                        month.removeAll()
                    }

                    stop = dates.count == 24
                    date = calendar.date(byAdding: .day, value: -1, to: date)!
                }
            }
            return dates
        }
    }

    static let avatarFilter = CircleFilter()
    static let avatarPlaceholder = #imageLiteral(resourceName: "default-avatar").af_imageRoundedIntoCircle()
}

protocol JSONConvertible {
    var json : JSON { get }
}

extension NSObject {
    static var classString : String {
        return NSStringFromClass(self)
    }
    var classString : String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
}

extension String {
    var localized: String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }

    var capitalizedFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
}

extension Array {
    subscript(_ indexes: [Int]) -> Array<Element> {
        var array = [Element]()
        for i in indexes {
            array.append(self[i])
        }
        return array
    }
}

extension UIImage {
    static func screenSized(_ name:String) -> UIImage? {
        return UIImage(named:name.appending("-\(Int(UIScreen.main.bounds.size.width))w")) ?? UIImage(named:name)
    }

    var upMirrored : UIImage {
        return oriented(.upMirrored)
    }

    func oriented(_ orientation:UIImageOrientation) -> UIImage {
        return UIImage(cgImage: cgImage!, scale: UIScreen.main.scale, orientation: orientation)
    }
}

extension UIImageView {
    convenience init(screenSized name:String) {
        self.init(image: UIImage.screenSized(name))
    }

    var avatarURL : URL? {
        get {
            return nil
        }
        set {
            if let url = newValue {
                af_setImage(withURL: url, placeholderImage:Common.avatarPlaceholder, filter:Common.avatarFilter, imageTransition:.crossDissolve(0.25))
            }
        }
    }
}

extension UIView {
    func removeAllSubviews() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
}

func desc(_ object:Any?) -> String {
    let anyObject : AnyObject = object as AnyObject
    guard let string = anyObject.description else { return ""}
    return string
}

func screenWidthSpecific<T>(w320:T, w375:T?, w414:T?) -> T {
    switch UIScreen.main.bounds.size.width {
        case 320: return w320
        case 375: return w375 ?? w320
        case 414: return w414 ?? w375 ?? w320

        default: return w320
    }
}

func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if LOG
        let stringItem = items.map {"\($0)"} .joined(separator: separator)
        print(stringItem, terminator: terminator)
    #endif
}

func remoteLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if REMOTE_LOG
        let stringItem = items.map {"\($0)"} .joined(separator: separator)
        print(stringItem, terminator: terminator)
    #endif
}

protocol Titled {
    var title : String { get }
    var subtitle : String? { get }
}

extension Titled {
    var subtitle : String? { return nil }
}

