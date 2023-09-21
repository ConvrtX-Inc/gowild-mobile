//
//  BaseProtocol.swift
//  GoWild
//
//  Created by SA - Haider Ali on 23/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol BaseProtocol: AnyObject{
    func didReceiveServer(error: [String]?,type: String,indexPath: Int)
    func didReceiveUnauthentic(error: [String]?)
}

extension BaseProtocol{
    func didReceiveServer(error: [String]?,type: String,indexPath: Int){}
    func didReceiveUnauthentic(error: [String]?) {}
}
