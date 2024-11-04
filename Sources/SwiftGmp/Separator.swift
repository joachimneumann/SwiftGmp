//
//  Separator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 04.11.2024.
//

public struct Separator: Codable {
    public enum SeparatorType: String, Codable, CaseIterable {
        case comma = ","
        case dot = "."
    }

//    public var encoded: String {
//        "\(separatorType.rawValue)-\(groups)"
//    }
//    
//    // Decode from a stored String
//    public static func decode(from string: String) -> Separator? {
//        let components = string.split(separator: "-")
//        guard components.count == 2,
//              let type = SeparatorType(rawValue: String(components[0])),
//              let groups = Bool(String(components[1]))
//        else { return nil }
//        return Separator(separatorType: type, groups: groups)
//    }

    public init(separatorType: SeparatorType, groups: Bool) {
        self.separatorType = separatorType
        self.groups = groups
    }
    public init() {
        self.separatorType = SeparatorType.dot
        self.groups = false
    }

    public var separatorType: SeparatorType
    public var groups: Bool

    public var character: Character {
        get {
            switch self.separatorType {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    public var string: String {
        get {
            switch self.separatorType {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    public var groupCharacter: Character? {
        get {
            if groups {
                switch self.separatorType {
                case .comma: return "."
                case .dot: return ","
                }
            } else {
                return nil
            }
        }
    }
    public var groupString: String? {
        get {
            if groups {
                switch self.separatorType {
                case .comma: return "."
                case .dot: return ","
                }
            } else {
                return nil
            }
        }
    }
}
