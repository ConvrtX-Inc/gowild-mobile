//
//  SupportMessageCell.swift
//  GoWild
//
//  Created by SA - Haider Ali on 19/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

protocol SupportMessageCellDelegates: AnyObject{
    func didTapOnAttachment(of url: String)
}

class SupportMessageCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var userImageView: UIImageView!{
        didSet{
            userImageView.cornerRadius = userImageView.frame.height / 2
        }
    }
    @IBOutlet weak var ticketInfoStackView: UIStackView!
    @IBOutlet weak var ticketNmbLbl: UILabel!{
        didSet{
            ticketNmbLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            ticketNmbLbl.textColor = AppColor.appWhiteColor()
        }
    }
    @IBOutlet weak var ticketStatusLbl: PaddingLabel!{
        didSet{
            ticketStatusLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 12)
            ticketStatusLbl.textColor = AppColor.appWhiteColor()
            ticketStatusLbl.clipsToBounds = true
            ticketStatusLbl.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var nameLbl: UILabel!{
        didSet{
            nameLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 18)
            nameLbl.textColor = AppColor.appWhiteColor()
        }
    }
    @IBOutlet weak var dateLbl: UILabel!{
        didSet{
            dateLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 14)
            dateLbl.textColor = AppColor.textLightYellow()
        }
    }
    @IBOutlet weak var messageLbl: UILabel!{
        didSet{
            messageLbl.font = Fonts.getSourceSansProRegularOf(size: 12)
            messageLbl.textColor = AppColor.appWhiteColor()
        }
    }
    
    @IBOutlet weak var attachmentsCollectionView: UICollectionView!{
        didSet{
            attachmentsCollectionView.delegate = self
            attachmentsCollectionView.dataSource = self
            attachmentsCollectionView.register(R.nib.supportAttachmentCell)
        }
    }
    
    var arrayOfAttachments : [String] = []{
        didSet{
            self.attachmentsCollectionView.reloadData()
        }
    }
    
    weak var delegate : SupportMessageCellDelegates?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//MARK: - EXTENSION FOR ATTACHMENT COLLECTION VIEW METHODS -

extension SupportMessageCell: CollectionViewMethods{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfAttachments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureAttachmentsCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row < (self.arrayOfAttachments.count)){
            let attachmentStr = self.arrayOfAttachments[indexPath.row]
            let urlStr = "\(UserManager.shared.getBaseURL())\(attachmentStr)"
            self.delegate?.didTapOnAttachment(of: urlStr)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 74.0, height: 74.0)
    }
    
}

//MARK: - EXTENSION FOR CELL METHODS -

extension SupportMessageCell{
    
    private func configureAttachmentsCell(at indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.attachmentsCollectionView.dequeueReusableCell(withReuseIdentifier: .supportAttachmentCell, for: indexPath) as! SupportAttachmentCell
        
        let attachment = self.arrayOfAttachments[indexPath.row]
        
        if attachment.contains(find: .pdf){
            cell.attachmentImageView.image = R.image.pdf_image()
        }else{
            if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(attachment)"){
                cell.attachmentImageView.kf.indicatorType = .activity
                cell.attachmentImageView.kf.setImage(with: imageURL)
            }
        }
        
        return cell
    }
    
}
