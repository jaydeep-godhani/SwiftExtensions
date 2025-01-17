//
//  Utils.swift
//  SwiftExtensions
//
//  Created by jaydeep-godhani on 10/01/25.
//

import UIKit

class Utils: NSObject {
    
    static let shared = Utils()
    
    func randomColor() -> (String, String) {
        let colors: [String: String] = [
            "#D32F2F": "#FFCDD2",
            "#C2185B": "#F8BBD0",
            "#7B1FA2": "#E1BEE7",
            "#303F9F": "#C5CAE9",
            "#0288D1": "#B3E5FC",
            "#43A047": "#C8E6C9",
            "#FBC02D": "#FFF9C4",
            "#E64A19": "#FFCCBC",
            "#5D4037": "#D7CCC8",
            "#455A64": "#CFD8DC",
            "#00897B": "#B2DFDB"
        ]
        
        let randomIndex = Int.random(in: 0..<colors.count)
        let colorPair = Array(colors)[randomIndex]
        
        return (colorPair.key, colorPair.value)
    }
    
    func formatPriceValue(_ num: Int64) -> String {
        switch num {
        case 100000000...:
            return String(format: "%.0fM", (num >= 10050000 ? Double(num - 500000) : Double(num)) / 1000000.0)
        case 10000000...:
            return String(format: "%.1fM", (num >= 10500000 ? Double(num - 50000) : Double(num)) / 1000000.0)
        case 1000000...:
            return String(format: "%.2fM", (num >= 1005000 ? Double(num - 5000) : Double(num)) / 1000000.0)
        case 100000...:
            return String(format: "%.1fk", (num >= 100500 ? Double(num - 500) : Double(num)) / 1000.0)
        case 10000...:
            return String(format: "%.1fk", (num >= 10550 ? Double(num - 50) : Double(num)) / 1000.0)
        case 1000...:
            return String(format: "%.2fk", (num >= 1005 ? Double(num - 5) : Double(num)) / 1000.0)
        default:
            return String(format: "%d", num)
        }
    }
    
    func getAgeUser(birthday: String) -> String {
        if birthday.isEmpty || birthday == "0000-00-00" || birthday == "00-00-0000" || birthday == "0" {
            return ""
        }
        let birthdayDate = birthday.toFormateStringToDate(from: "yyyy-MM-dd")
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthdayDate, to: now)
        return "\(ageComponents.year ?? 0)"
    }
    
    // Precompiled regex
    private let smileRegex: NSRegularExpression = {
        let pattern = "<i class=\"twa-lg twa twa-(.*?)\"></i>"
        return try! NSRegularExpression(pattern: pattern, options: [])
    }()
    
    func getSmileTypeIcon(from text: String?) -> String {
        guard let text = text, !text.isEmpty else {
            return ""
        }

        // Dictionary mapping smile types to their corresponding emoji
        let dictionary: [String: String] = [
            "smile": "😀",
            "joy": "😂",
            "relaxed": "😚",
            "stuck-out-tongue-winking-eye": "😛",
            "stuck-out-tongue": "😜",
            "sunglasses": "😎",
            "wink": "😉",
            "grin": "😁",
            "smirk": "😏",
            "innocent": "😇",
            "cry": "😢",
            "sob": "😭",
            "disappointed": "😞",
            "kissing-heart": "😘",
            "heart": "❤️",
            "broken-heart": "💔",
            "heart-eyes": "😍",
            "star": "⭐",
            "open-mouth": "😦",
            "scream": "😱",
            "anguished": "😨",
            "unamused": "😒",
            "angry": "😡",
            "rage": "😡",
            "expressionless": "😑",
            "confused": "😕",
            "neutral-face": "😐",
            "exclamation": "❗",
            "yum": "😋",
            "triumph": "😤",
            "imp": "😈",
            "hear-no-evil": "🙉",
            "alien": "👽",
            "yellow-heart": "💛",
            "sleeping": "😴",
            "mask": "😷",
            "no-mouth": "😈",
            "weary": "😩",
            "dizzy-face": "😵",
            "man": "👨",
            "woman": "👩",
            "boy": "👦",
            "girl": "👧",
            "older-man": "👴",
            "older-woman": "👵",
            "cop": "👨‍✈️",
            "dancers": "👯",
            "speak-no-evil": "🙊",
            "lips": "👄",
            "see-no-evil": "🙈",
            "dog": "🐕",
            "bear": "🐻",
            "rose": "🌹",
            "gift-heart": "💝",
            "ghost": "👻",
            "bell": "🔔",
            "video-game": "🎮",
            "soccer": "⚽",
            "books": "📚",
            "moneybag": "💰",
            "mortar-board": "🎓",
            "hand": "🤚",
            "tiger": "🐅",
            "elephant": "🐘",
            "scream-cat": "🙀",
            "monkey": "🐒",
            "bird": "🐦",
            "snowflake": "❄️",
            "sunny": "☀️",
            "ocean": "🌊",
            "umbrella": "☂️",
            "hibiscus": "🌺",
            "tulip": "🌷",
            "computer": "💻",
            "bomb": "💣",
            "gem": "💎",
            "ring": "💍"
        ]

        var modifiedText = text
        let matches = self.smileRegex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        for match in matches.reversed() {
            if let range = Range(match.range(at: 1), in: text) {
                let type = String(text[range])
                if let emoji = dictionary[type] {
                    let iconTag = "<i class=\"twa-lg twa twa-\(type)\"></i>"
                    modifiedText = modifiedText.replacingOccurrences(of: iconTag, with: emoji)
                }
            }
        }
        return modifiedText
    }
    
}
