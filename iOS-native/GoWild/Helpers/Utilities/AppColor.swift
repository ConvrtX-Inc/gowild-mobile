//
//  AppColor.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

final class AppColor{
    
    private init() {}
    
    static func bgBlackColor() -> UIColor?{
        return R.color.appBgBlack()
    }
    
    static func textLightYellow() -> UIColor?{
        return R.color.textLightYellow()
    }
    
    static func appYellowColor() -> UIColor?{
        return R.color.appYellowColor()
    }
    
    static func appBgColor() -> UIColor?{
        return R.color.appBgColor()
    }
    
    static func appTabbarBgColor() -> UIColor?{
        return R.color.appTabbarBgColor()
    }
    
    static func appLightBlueColor() -> UIColor?{
        return R.color.appLightBlueColor()
    }
    
    static func appRedColor() -> UIColor?{
        return R.color.appRedColor()
    }
    
    static func appWhiteColor() -> UIColor?{
        return R.color.appWhiteColor()
    }
    
    static func textFieldBgColor() -> UIColor?{
        return R.color.textFieldBgColor()
    }
    
    static func textFieldBorderColor() -> UIColor?{
        return R.color.textFieldBorderColor()
    }
    
    static func textDarkGrayColor() -> UIColor?{
        return R.color.textDarkGrayColor()
    }
    
    static func textLightGrayColor() -> UIColor?{
        return R.color.textLightGrayColor()
    }
    
    static func textLightOrangeColor() -> UIColor?{
        return R.color.textLightOrangeColor()
    }
    
    static func textDarkOrangeColor() -> UIColor?{
        return R.color.textDarkOrangeColor()
    }
    
    static func appOrangeBgColor() -> UIColor?{
        return R.color.appOrangeBgColor()
    }
    
    static func cardBorderColor() -> UIColor?{
        return R.color.cardBorderColor()
    }
    
    static func appLightBrownColor() -> UIColor?{
        return R.color.appLightBrownColor()
    }
    
    static func appLightGreenBgColor() -> UIColor?{
        return R.color.appLightGreenBgColor()
    }
    
    static func appChatBgColor() -> UIColor?{
        return R.color.appChatBgColor()
    }
    
    static func appInputBarColor() -> UIColor?{
        return R.color.appInputBarColor()
    }
    
    static func supportPlaceHolderColor() -> UIColor?{
        return R.color.supportPlaceHolderColor()
    }
    
    static func routePolylineGreenColor() -> UIColor{
        return R.color.routePolylineGreenColor() ?? .systemGreen
    }
    
    static func routePolylineOrangeColor() -> UIColor{
        return R.color.routePolylineOrangeColor() ?? .systemOrange
    }
    
    static func routePolylineColor() -> UIColor{
        return R.color.routePolylineColor() ?? .systemOrange
    }
    
    static func userPolylineColor() -> UIColor{
        return R.color.userPolylineColor() ?? .systemBlue
    }
    
    
}
