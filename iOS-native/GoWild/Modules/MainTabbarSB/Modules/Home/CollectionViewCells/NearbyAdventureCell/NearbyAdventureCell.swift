//
//  NearbyAdventureCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 15/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class NearbyAdventureCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hidePostBtn: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 24)
            titleLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var companyNameLbl: UILabel!{
        didSet{
            companyNameLbl.font = Fonts.getSourceSansProBoldOf(size: 16)
            companyNameLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var sponsoredLbl: UILabel!{
        didSet{
            sponsoredLbl.font = Fonts.getSourceSansProBoldOf(size: 12)
        }
    }
    @IBOutlet weak var dateLbl: UILabel!{
        didSet{
            dateLbl.font = Fonts.getSourceSansProBoldOf(size: 16)
            dateLbl.textColor = AppColor.textLightOrangeColor()
        }
    }
    @IBOutlet weak var timeLbl: UILabel!{
        didSet{
            timeLbl.font = Fonts.getSourceSansProBoldOf(size: 16)
            timeLbl.textColor = AppColor.textLightOrangeColor()
        }
    }
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var cosmosView: CosmosView!{
        didSet{
            cosmosView.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var visitLbl: UILabel!{
        didSet{
            visitLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
            visitLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var visitCountLbl: UILabel!{
        didSet{
            visitCountLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
            visitCountLbl.textColor = AppColor.appWhiteColor()
        }
    }
    @IBOutlet weak var milesView: UIView!
    @IBOutlet weak var milesLbl: UILabel!{
        didSet{
            milesLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
            milesLbl.textColor = AppColor.bgBlackColor()
        }
    }
    @IBOutlet weak var descriptionLbl: UILabel!{
        didSet{
            descriptionLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
        }
    }
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var registerLbl: UILabel!{
        didSet{
            registerLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            registerLbl.textColor = AppColor.textDarkGrayColor()
            registerLbl.text = GoWildStrings.registered()
        }
    }
    @IBOutlet weak var leftLbl: UILabel!{
        didSet{
            leftLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            leftLbl.textColor = AppColor.textLightOrangeColor()
        }
    }
    @IBOutlet weak var peopleCollectionView: UICollectionView!{
        didSet{
            peopleCollectionView.delegate = self
            peopleCollectionView.dataSource = self
            peopleCollectionView.register(R.nib.nearbyAdventurePeopleCell)
        }
    }
    @IBOutlet weak var registerbtnView: UIView!
    @IBOutlet weak var registerBtn: LoadingButton!{
        didSet{
            registerBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
            registerBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
        }
    }
    
    @IBOutlet weak var sponsorCollectionView: UICollectionView!{
        didSet{
            sponsorCollectionView.delegate = self
            sponsorCollectionView.dataSource = self
            sponsorCollectionView.register(R.nib.sponsoredCell)
        }
    }
    
    var arrayOfPeoples : [TreasureHunts] = []{
        didSet{
            peopleCollectionView.reloadData()
        }
    }
    
    var arrayOfSponsored : [TreasureHuntSponsors] = []{
        didSet{
            sponsorCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//MARK: - EXTENSION FOR COLLECTION VIEW METHODS -

extension NearbyAdventureCell: CollectionViewMethods{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case peopleCollectionView:
            if self.arrayOfPeoples.count > 5{
                return 5
            }else{
                return self.arrayOfPeoples.count
            }
        case sponsorCollectionView:
            return arrayOfSponsored.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case peopleCollectionView:
            return configurePeopleCell(at: indexPath)
        case sponsorCollectionView:
            return configureSponsorCell(at: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case peopleCollectionView:
            Constants.printLogs("***********")
        case sponsorCollectionView:
            let sponsor = self.arrayOfSponsored[indexPath.row]
            Constants.printLogs("\(sponsor.link ?? "")")
        default:
            Constants.printLogs("***********")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case peopleCollectionView:
            return CGSize(width: 50, height: 50)
        case sponsorCollectionView:
            return CGSize(width: 16, height: sponsorCollectionView.frame.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
}

extension NearbyAdventureCell{
    
    private func configurePeopleCell(at indexPath: IndexPath) -> UICollectionViewCell{
        let cell = peopleCollectionView.dequeueReusableCell(withReuseIdentifier: .nearbyAdventurePeopleCell, for: indexPath) as! NearbyAdventurePeopleCell
        
        let peoples = self.arrayOfPeoples[indexPath.row]
        
        if self.arrayOfPeoples.count > 5{
            if indexPath.row == 4{
                cell.peopleImageView.image = nil
                cell.peopleImageView.backgroundColor = AppColor.textDarkGrayColor()
                cell.countLbl.isHidden = false
                cell.countLbl.text = "+\(self.arrayOfPeoples.count - 4)"
            }else{
                cell.countLbl.isHidden = true
                cell.peopleImageView.backgroundColor = AppColor.appWhiteColor()
                if let peopleImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(peoples.users?.userPhoto ?? "")"){
                    cell.peopleImageView.kf.indicatorType = .activity
                    cell.peopleImageView.kf.setImage(with: peopleImageURL,placeholder: R.image.ic_user_placeholder_image())
                }
            }
        }else{
            cell.countLbl.isHidden = true
            cell.peopleImageView.backgroundColor = AppColor.appWhiteColor()
            if let peopleImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(peoples.users?.userPhoto ?? "")"){
                cell.peopleImageView.kf.indicatorType = .activity
                cell.peopleImageView.kf.setImage(with: peopleImageURL,placeholder: R.image.ic_user_placeholder_image())
            }
        }
        
        return cell
    }
    
    private func configureSponsorCell(at indexPath: IndexPath) -> UICollectionViewCell{
        let cell = sponsorCollectionView.dequeueReusableCell(withReuseIdentifier: .sponsoredCell, for: indexPath) as! SponsoredCell
        
        let sponsor = self.arrayOfSponsored[indexPath.row]
        if let sponsorImageURL = URL(string: "\(UserManager.shared.getBaseURL())\(sponsor.img ?? "")"){
            cell.sponsoredImageView.kf.indicatorType = .activity
            cell.sponsoredImageView.kf.setImage(with: sponsorImageURL)
        }
        
        return cell
    }
    
}
