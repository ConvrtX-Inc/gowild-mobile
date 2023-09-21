//
//  GenderVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 09/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

protocol GenderVCDelegates: AnyObject{
    func didSelectGenderOf(name: String)
}

class GenderVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.clipsToBounds = true
            backView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        }
    }
    @IBOutlet weak var genderTableView: UITableView!{
        didSet{
            genderTableView.delegate = self
            genderTableView.dataSource = self
            genderTableView.register(R.nib.genderCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    let genders : [String] = ["Male", "Female", "Other"]
    weak var delegate : GenderVCDelegates?
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - EXTENSION FOR METHODS -
    
    
    
    //MARK: - ACTIONS -
    
    @IBAction func didTApDismissBtn(_ sender: UIButton){
        sender.showAnimation {
            self.dismiss(animated: true)
        }
    }


}

//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension GenderVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureGenderCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gender = self.genders[indexPath.row]
        self.delegate?.didSelectGenderOf(name: gender)
        self.dismiss(animated: true)
    }
    
}

//MARK: - EXTENSION FOR GENDER CELL -

extension GenderVC{
    
    private func configureGenderCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.genderTableView.dequeueReusableCell(withIdentifier: .genderCell, for: indexPath) as! GenderCell
        cell.nameLbl.text = self.genders[indexPath.row]
        if indexPath.row == (genders.count - 1){
            cell.seperatorView.isHidden = true
        }else{
            cell.seperatorView.isHidden = false
        }
        return cell
    }
    
}
