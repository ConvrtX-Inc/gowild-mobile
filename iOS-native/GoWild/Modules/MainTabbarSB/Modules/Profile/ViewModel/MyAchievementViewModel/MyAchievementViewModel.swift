//
//  MyAchievementViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation

protocol MyAchievementViewModelDelegates: BaseProtocol{
    func didGetMyAchievements(response: MyAchievementResponse)
    func didGetMyAchievementsResponseWith(error: String)
}

final class MyAchievementViewModel{
    
    weak var delegates : MyAchievementViewModelDelegates?
    private let validator = MyAchievementValidations()
    private let resource = MyAchievementResource()
    
    func getMyAchievements(){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.getMyAchievements { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetMyAchievementsResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetMyAchievementsResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetMyAchievementsResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetMyAchievements(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetMyAchievementsResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
