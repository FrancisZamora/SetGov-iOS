//
//  constants.swift
//  SetGov
//
//  Created by Francis Zamora on 2/27/17.
//  Copyright © 2017 Francis. All rights reserved.
//

import Foundation
import UIKit
/*
 * FONTS
 */

/**
 Sets up a curried function that stores the desired font name in a closure.
 The returned function accepts the desired font size as its only parameter.
 This is combined with the font name to return the desired UIFont specification.
 */
func SIZEABLE_FONT_WITH_NAME(name: String) -> ((CGFloat) -> UIFont) {
    return { UIFont(name: name, size: $0)! }
}

//adapted from setmine
let AVENIR_LIGHT = SIZEABLE_FONT_WITH_NAME(name: "Avenir-Light")
let AVENIR_BOOK = SIZEABLE_FONT_WITH_NAME(name: "Avenir-Book")
let AVENIR_MEDIUM = SIZEABLE_FONT_WITH_NAME(name: "Avenir-Medium")
let AVENIR_HEAVY = SIZEABLE_FONT_WITH_NAME(name: "Avenir-Heavy")



/*
 * COLORS
 */

let SG_PRIMARY_BLUECOLOR = UIColor(red:0.13, green:0.19, blue:0.25, alpha:1.0)
let SG_SECONDARY_BLUECOLOR = UIColor(red:0.18, green:0.26, blue:0.35, alpha:1.0)
let SG_RED_COLOR = UIColor(red:0.71, green:0.10, blue:0.11, alpha:1.0)
let SG_SECONDARY_REDCOLOR = UIColor(red:0.51, green:0.03, blue:0.02, alpha:1.0)
let SG_PRIMARY_WHITECOLOR = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)


let SG_GREEN_COLOR = UIColor(red: 54/255.0, green: 215/255.0, blue: 183/255.0, alpha: 1.0)
// Grayscale Colors, adapted from Setmine
let SG_CLEAR_COLOR = UIColor(white: 0.0, alpha: 0.0)
let SG_TRANSPARENT_COLOR = UIColor(white: 0.8, alpha: 0.0)
let SG_DARK_GRAY_COLOR = UIColor(white: 0.2, alpha: 1.0)
let SG_FOLLOWING_GRAY_COLOR = UIColor(white: 0.588, alpha: 1.0)
let SG_MEDIUM_GRAY_COLOR = UIColor(white: 0.8, alpha: 1.0)
let SG_LOCKED_GRAY_COLOR = UIColor(white: 0.90, alpha: 1.0)
let SG_LIGHT_GRAY_COLOR = UIColor(white: 0.95, alpha: 1.0)
let SG_NEARLY_WHITE_COLOR = UIColor(white: 0.9686, alpha: 1.0)

// Third Party Colors
let FACEBOOK_BLUE = UIColor(red: 59/255.0, green: 89/255.0, blue: 152/255.0, alpha: 1.0)
let TWITTER_BLUE_COLOR = UIColor(red: 64/255.0, green: 153/255.0, blue: 255/255.0, alpha: 1.0)
let INSTAGRAM_BLUE_COLOR = UIColor(red: 81/255.0, green: 127/255.0, blue: 164/255.0, alpha: 1.0)

let DATA_SET_COLORS = [
    SG_RED_COLOR,
    SG_PRIMARY_BLUECOLOR,
    SG_SECONDARY_REDCOLOR,
    SG_SECONDARY_BLUECOLOR
]
