//
//  GuideLineResponse.swift
//  GoWild
//
//  Created by SA - Haider Ali on 19/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

struct GuideLineResponse: Codable{
    let data : GuideLineResponseData?
    let faq : [FaqsResponseData]?
    let message : String?
    let errors : [[String: String]]?
}

struct GuideLineResponseData: Codable{
    let id : String?
    let createdDate : String?
    let type : String?
    let description : String?
}

struct FaqsResponseData: Codable{
    let id : String?
    let question : String?
    let description : String?
    let type : String?
}


enum GuideLineType: String{
    case termsAndConditions
    case faq
    case eWaiver
    case huntEWaiver
}
