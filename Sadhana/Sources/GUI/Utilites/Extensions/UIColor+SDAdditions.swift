//
//  UIColor+SDAdditions.swift
//
//  Generated by Zeplin on 7/16/17.
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved. 
//



extension UIColor {
    class var sdTangerine: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 140.0 / 255.0, blue: 0.0, alpha: 1.0)
    }

    class var sdButterscotch: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 182.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
    }

    class var sdDarkTaupe: UIColor {
        return UIColor(red: 98.0 / 255.0, green: 61.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
    }

    class var sdPaleGrey: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 244.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }

    class var sdSunflowerYellow: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 219.0 / 255.0, blue: 0.0, alpha: 1.0)
    }

    class var sdBrightBlue: UIColor {
        return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    class var sdNeonRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 0.0, blue: 72.0 / 255.0, alpha: 1.0)
    }

    class var sdSilver: UIColor {
        return UIColor(red: 206.0 / 255.0, green: 210.0 / 255.0, blue: 213.0 / 255.0, alpha: 1.0)
    }
    
    class var sdBrownishGrey: UIColor { 
        return UIColor(white: 104.0 / 255.0, alpha: 1.0)
    }

    class var sdMudBrown12: UIColor {
        return UIColor(red: 80.0 / 255.0, green: 53.0 / 255.0, blue: 21.0 / 255.0, alpha: 0.12)
    }

    class var sdLightPeach: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 194.0 / 255.0, blue: 194.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var sdSteel: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }

    class var sdSeparatorGreyColor: UIColor {
        return UIColor(white: 0.86, alpha: 1.0)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

// Text styles

extension UIFont {
    class func sdTextStyle1Font() -> UIFont {
        return UIFont.systemFont(ofSize: 33.0, weight: UIFont.Weight.light)
    }

    class var sdTextStyle1_1Font: UIFont {
        return UIFont.systemFont(ofSize: 25.0, weight: UIFont.Weight.regular)
    }

    class func sdTextStyle2Font() -> UIFont {
        return UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
    }

    class func sdTextStyle3Font() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
    }

    class var sdTextStyle4Font: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.regular)
    }

    class var sdTextStyle5Font: UIFont {
        return UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.regular)
    }
}
