//
//  Color.swift
//  ColorLoversApp
//
//

import Foundation

class Color: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true

    var count: Int
    var color1Hex: String
    var color2Hex: String
    var color3Hex: String
    var color4Hex: String
    var color5Hex: String

    init(count: Int, color1Hex: String, color2Hex: String, color3Hex: String, color4Hex: String, color5Hex: String) {
        self.count = count
        self.color1Hex = color1Hex
        self.color2Hex = color2Hex
        self.color3Hex = color3Hex
        self.color4Hex = color4Hex
        self.color5Hex = color5Hex
    }

    required init?(coder aDecoder: NSCoder) {
        self.count = aDecoder.decodeInteger(forKey: "count")
        self.color1Hex = aDecoder.decodeObject(of: NSString.self, forKey: "color1Hex") as! String
        self.color2Hex = aDecoder.decodeObject(of: NSString.self, forKey: "color2Hex") as! String
        self.color3Hex = aDecoder.decodeObject(of: NSString.self, forKey: "color3Hex") as! String
        self.color4Hex = aDecoder.decodeObject(of: NSString.self, forKey: "color4Hex") as! String
        self.color5Hex = aDecoder.decodeObject(of: NSString.self, forKey: "color5Hex") as! String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.count, forKey: "count")
        aCoder.encode(self.color1Hex, forKey: "color1Hex")
        aCoder.encode(self.color2Hex, forKey: "color2Hex")
        aCoder.encode(self.color3Hex, forKey: "color3Hex")
        aCoder.encode(self.color4Hex, forKey: "color4Hex")
        aCoder.encode(self.color5Hex, forKey: "color5Hex")
    }
}
