//
//  String + Extensions.swift
//  SwiftExtensions
//
//  Created by jaydeep-godhani on 10/01/25.
//

import Foundation

extension String {
    
    func unixTimeStampToDateTime(_ time: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: time)
    }
    
    // Calculate time ago
    func timeAgo(withReplace: Bool) -> String {
        let time = TimeInterval(self) ?? 0
        let dateTime = self.unixTimeStampToDateTime(time)
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: dateTime, to: Date())
        var result: String
        if let years = difference.year, years > 0 {
            result = "\(years) Year ago"
        } else if let months = difference.month, months > 0 {
            result = "\(months) Month ago"
        } else if let days = difference.day, days > 0 {
            result = days > 1 ? "\(days) Days ago" : "Yesterday"
        } else if let hours = difference.hour, hours > 0 {
            result = "\(hours) Hours ago"
        } else if let minutes = difference.minute, minutes > 0 {
            result = "\(minutes) Minutes ago"
        } else if let seconds = difference.second, seconds > 0 {
            result = "Just now"
        } else {
            result = "Just now"
        }
        return withReplace ? replaceTime(result) : result
    }
    
    // Replace time labels
    func replaceTime(_ time: String) -> String {
        var updatedTime = time.lowercased()
        if updatedTime.contains("hours ago") || updatedTime.contains("hour ago") {
            updatedTime = updatedTime.replacingOccurrences(of: "hours ago", with: "H")
            updatedTime = updatedTime.replacingOccurrences(of: "hour ago", with: "H")
        } else if updatedTime.contains("days ago") || updatedTime.contains("day ago") {
            updatedTime = updatedTime.replacingOccurrences(of: "days ago", with: "D")
            updatedTime = updatedTime.replacingOccurrences(of: "day ago", with: "D")
        } else if updatedTime.contains("months ago") || updatedTime.contains("month ago") {
            updatedTime = updatedTime.replacingOccurrences(of: "months ago", with: "M")
            updatedTime = updatedTime.replacingOccurrences(of: "month ago", with: "M")
        } else if updatedTime.contains("minutes ago") || updatedTime.contains("minute ago") {
            updatedTime = updatedTime.replacingOccurrences(of: "minutes ago", with: "Min")
            updatedTime = updatedTime.replacingOccurrences(of: "minute ago", with: "Min")
        } else if updatedTime.contains("seconds ago") || updatedTime.contains("second ago") {
            updatedTime = updatedTime.replacingOccurrences(of: "seconds ago", with: "Sec")
            updatedTime = updatedTime.replacingOccurrences(of: "second ago", with: "Sec")
        } else if updatedTime.contains("year ago") || updatedTime.contains("years ago") {
            updatedTime = updatedTime.replacingOccurrences(of: "year ago", with: "Y")
            updatedTime = updatedTime.replacingOccurrences(of: "years ago", with: "Y")
        } else if updatedTime.contains("yesterday") {
            updatedTime = updatedTime.replacingOccurrences(of: "yesterday", with: "Yesterday")
        }
        return updatedTime
    }
    
    func toFormateStringToDate(from: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = from
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
}

extension String {
    
    func decodeString() -> String {
        guard !self.isEmpty else { return "" }
        var text = self
        
        // Decode emojis
        if text.contains("<i class=") {
            text = Utils.shared.getSmileTypeIcon(from: text)
        }
        
        // Replace shorthand with emojis
        text = text
            .replacingOccurrences(of: ":)", with: "😊")
            .replacingOccurrences(of: ";)", with: "😉")
            .replacingOccurrences(of: "0)", with: "😇")
            .replacingOccurrences(of: "(<", with: "😂")
            .replacingOccurrences(of: ":D", with: "😁")
            .replacingOccurrences(of: "*_*", with: "😍")
            .replacingOccurrences(of: "<3", with: "❤️")
            .replacingOccurrences(of: "/_)", with: "😏")
            .replacingOccurrences(of: "-_-", with: "😑")
            .replacingOccurrences(of: ":-/", with: "😕")
            .replacingOccurrences(of: ":*", with: "😘")
            .replacingOccurrences(of: ":p", with: "😛")
            .replacingOccurrences(of: "x(", with: "😠")
            .replacingOccurrences(of: ":_(", with: "😢")
            .replacingOccurrences(of: ":0", with: "😱")
            .replacingOccurrences(of: "B)", with: "😎")
            .replacingOccurrences(of: "o(", with: "😧")
            .replacingOccurrences(of: ":o", with: "😮")
            .replacingOccurrences(of: "</3", with: "💔")
            .replacingOccurrences(of: "!_", with: "❗")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&#36;", with: "$")
            .replacingOccurrences(of: "&#8364;", with: "€")
            .replacingOccurrences(of: "&#163;", with: "£")
            .replacingOccurrences(of: "&#165;", with: "¥")
        
        return text.decodeHtmlEntities() ?? text
    }
    
    func decodeHtmlEntities() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil).string
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    static func randomStringWithLength(length : Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    func subStringCutOf(_ x: Int) -> String {
        if self.count > x {
            let index = self.index(self.startIndex, offsetBy: x)
            return String(self[..<index]) + "..."
        }
        return self
    }
    
}

extension String {
    
    func extractYouTubeID() -> String? {
        let pattern = #"(?<=watch\?v=|/videos/|embed/|youtu.be/|\/v\/|\/e\/|watch\?v%3D|watch\?v%3D|%2Fvideos%2F|embed%2F|youtu.be%2F|%2Fv%2F)[^#\&\?]*"#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let nsString = self as NSString
            let results = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if let range = results?.range {
                return nsString.substring(with: range)
            }
        } catch let error {
            print("Invalid regex: \(error.localizedDescription)")
        }
        
        return nil
    }
    
}

extension String {
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
}

extension String {
    
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
    
}
