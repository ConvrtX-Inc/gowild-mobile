//
//  Fonts.swift
//  GoWild
//
//  Created by SA - Haider Ali on 08/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

final class Fonts{
    
    private init () {}
    
    //MARK: - Foregen Rough One -
    
    static func getForegenRoughOneFontOf(size: CGFloat) -> UIFont? {
        return R.font.theForegenRoughOne(size: size)
    }
    
    //MARK: - DIGITAL NUMBERS -
    
    static func getDigitalNumbersRegularOf(size: CGFloat) -> UIFont? {
        return R.font.digitalNumbersRegular(size: size)
    }
    
    static func getdigital7Of(size: CGFloat) -> UIFont? {
        return R.font.digital7(size: size)
    }
    
    //MARK: - SOURCE SANS PRO -
    
    static func getSourceSansProLightOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProLight(size: size)
    }
    
    static func getSourceSansProRegularOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProRegular(size: size)
    }
    
    static func getSourceSansProSemiBoldOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProSemiBold(size: size)
    }
    
    static func getSourceSansProBoldOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProBold(size: size)
    }
    
    static func getSourceSansProBlackOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProBlack(size: size)
    }
    
    static func getSourceSansProExtraLightOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProExtraLight(size: size)
    }
    
    static func getSourceSansProExtraLightItalicOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProExtraLightItalic(size: size)
    }
    
    static func getSourceSansProBlackItalicOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProBlackItalic(size: size)
    }
    
    static func getSourceSansProSemiBoldItalicOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProSemiBoldItalic(size: size)
    }
    
    static func getSourceSansProBoldItalicOf(size: CGFloat) -> UIFont? {
        return R.font.sourceSansProBoldItalic(size: size)
    }
    
}
