//
//  NotificationListViewModel.swift
//  GoWild
//
//  Created by SA - Haider Ali on 30/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation

protocol NotificationListViewModelDelegates: BaseProtocol{
    func didGetAllNotifications(response: NotificationListResponse)
    func didGetAllNotificationsResponseWith(error: String)
}

final class NotificationListViewModel{
    
    weak var delegates : NotificationListViewModelDelegates?
    private let validator = NotificationListValidation()
    private let resource = NotificationListResource()
    
    func getAllNotifications(){
        
        let validationResult = validator.validateRequest()
        
        if validationResult.success{
            
            resource.getNotifications { response, statusCode in
                
                DispatchQueue.main.async {
                    
                    guard let statusCode = statusCode else { return }
                    
                    switch statusCode{
                        
                    case 401:
                        self.delegates?.didReceiveUnauthentic(error: [response?.message ?? GoWildStrings.oopsSomethingWentWrong()])
                        
                    case 500...599:
                        self.delegates?.didReceiveServer(error: [GoWildStrings.oopsSomethingWentWrong()], type: "", indexPath: 0)
                    default:
                        guard let result = response else {
                            self.delegates?.didGetAllNotificationsResponseWith(error: GoWildStrings.oopsSomethingWentWrong())
                            return
                        }
                        if result.errors != nil{
                            if let errorDict = result.errors?.first{
                                self.delegates?.didGetAllNotificationsResponseWith(error: errorDict.convertBackendErrorToString())
                            }else{
                                self.delegates?.didGetAllNotificationsResponseWith(error: response?.message ?? GoWildStrings.oopsSomethingWentWrong())
                            }
                        }else{
                            self.delegates?.didGetAllNotifications(response: result)
                        }
                    }
                    
                }
            }
            
        }else{
            self.delegates?.didGetAllNotificationsResponseWith(error: validationResult.message ?? GoWildStrings.oopsSomethingWentWrong())
        }
        
    }
    
}
