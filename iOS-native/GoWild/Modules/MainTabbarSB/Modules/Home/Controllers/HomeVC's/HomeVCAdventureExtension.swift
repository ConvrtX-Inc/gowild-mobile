//
//  HomeVCAdventureExtension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 03/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import Foundation
import UIKit

//MARK: - EXTENSION FOR VC METHODS -

extension HomeVC{
    
    func setNearbyAdventureSection(){
        if Network.isAvailable{
            if !self.nearbySectionBtn.isSelected{
                LoaderView.shared.showSpiner(inVC: self)
                self.getTreasureHunts()
            }else{
                self.currentPage = 0
                self.arrayOfNearbyEvents.removeAll()
                DispatchQueue.main.async {
                    self.nearbyAdventureCollectionView.reloadData()
                }
            }
            self.nearbySectionBtn.isSelected = !self.nearbySectionBtn.isSelected
            UIView.animate(withDuration: 0.3) {
                self.nearbySubSectionView.isHidden = true
            }
        }else{
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsNetworkError())
        }
    }
    
}

//MARK: - EXTENSION FOR TREASURE HUNT CELL -

extension HomeVC{
    
     func configureNearbyAdventureCell(at indexPath: IndexPath) -> UICollectionViewCell{
        let cell = nearbyAdventureCollectionView.dequeueReusableCell(withReuseIdentifier: .nearbyAdventureCell, for: indexPath) as! NearbyAdventureCell
        
        cell.registerbtnView.isHidden = false
        cell.companyView.isHidden = false
        cell.ratingView.isHidden = true
        cell.hidePostBtn.isHidden = true
        cell.milesView.isHidden = true
        cell.registerView.isHidden = false
        cell.registerbtnView.isHidden = true
        
        let treasureHunt = self.arrayOfNearbyEvents[indexPath.row]
        
        if let huntImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(treasureHunt.picture ?? "")"){
            cell.postImageView.kf.indicatorType = .activity
            cell.postImageView.kf.setImage(with: huntImageURL)
        }
        
        cell.titleLbl.text = treasureHunt.title
        cell.descriptionLbl.text = treasureHunt.description
        cell.arrayOfSponsored = treasureHunt.sponsors ?? []
        cell.arrayOfPeoples = treasureHunt.treasureHunts ?? []
        cell.dateLbl.text = Utils.shared.getTreasureWildFeedDate(utcDate: treasureHunt.eventDate ?? "")
        cell.timeLbl.text = Utils.shared.getTreasureWildFeedTime(utcDate: treasureHunt.eventDate ?? "")
        let leftUsers = ((treasureHunt.nmbOfParticipants ?? 0) - (treasureHunt.treasureHunts?.count ?? 0))
        cell.leftLbl.text = "\(leftUsers)/\(treasureHunt.nmbOfParticipants ?? 0) \(GoWildStrings.left())"
        
        cell.hidePostBtn.addTapGestureRecognizer {
            Constants.printLogs("***** HidePostBtn Tapped *****")
        }
        
        return cell
    }
    
}

//MARK: - EXTENSION FOR TREASURE HUNT VIEWMODEL DELEGATES -

extension HomeVC: TreasureHuntViewModelDelegates{
    
    func didGetTreasureHunt(response: TreasureHuntResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.isPageRefreshing = false
        self.currentPage = response.currentPage ?? 0
        self.totalPage = response.totalPage ?? 0
        if let events = response.data{
            if !events.isEmpty{
                for event in events {
                    if let status = event.status,
                       let eventDate = event.eventDate{
                        if self.checkEventIsAfterToday(date: eventDate) && status == TreasureWildCardStatus.pending.rawValue{
                            self.arrayOfNearbyEvents.append(event)
//                            self.checkUserIsRegisterOrNot()
                        }
                    }
                }
                
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {return}
            if weakSelf.arrayOfNearbyEvents.count > 0{
                weakSelf.nearbyCountLbl.isHidden = false
                weakSelf.nearbyCountLbl.text = "\(weakSelf.arrayOfNearbyEvents.count)"
                UIView.animate(withDuration: 0.3) {
                    weakSelf.nearbySubSectionView.isHidden = false
                }
            }else{
                weakSelf.nearbyCountLbl.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    weakSelf.nearbySubSectionView.isHidden = true
                }
            }
            weakSelf.nearbyAdventureCollectionView.reloadData()
        }
    }
    
    func didGetTreasureHuntResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        self.isPageRefreshing = false
        DispatchQueue.main.async { [weak self] in
            self?.nearbyAdventureCollectionView.reloadData()
        }
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
}


extension HomeVC{
    
    private func checkEventIsAfterToday(date: String) -> Bool{
        if let eventDate = Utils.shared.getDateObjFromStringUsingChatGPT(date){
            let currentDate = Date()
            if eventDate > currentDate{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
}
