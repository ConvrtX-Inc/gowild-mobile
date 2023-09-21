//
//  MapOverlayVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 05/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

class MapOverlayVC: UIViewController {
    
    //MARK: - OUTLETES -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mapOverlayTableView: UITableView!{
        didSet{
            mapOverlayTableView.delegate = self
            mapOverlayTableView.dataSource = self
            mapOverlayTableView.register(R.nib.mapOverlayCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var mapOverlayVM = MapOverLayViewModel.shared
    var arrayOfMapType : [MapOverlayModel] = []{
        didSet{
            self.mapOverlayTableView.reloadData()
        }
    }
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.mapOverlay().capitalized
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        self.arrayOfMapType = mapOverlayVM.getCurrentMapStyles()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    //MARK: - ACTIONS

    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}


//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension MapOverlayVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMapType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureMapOverlayCell(at: indexPath)
    }
    
}

//MARK: - EXTENSION FOR CELLS METHOD -

extension MapOverlayVC{
    
    private func configureMapOverlayCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.mapOverlayTableView.dequeueReusableCell(withIdentifier: .mapOverlayCell, for: indexPath) as! MapOverlayCell
        
        let map = self.arrayOfMapType[indexPath.row]
        cell.mapImageView.image = UIImage(named: map.image)
        cell.nameLbl.text = map.name
        if map.isSelected{
            cell.setBtn.setTitle(GoWildStrings._default(), for: .normal)
            cell.setBtn.setTitleColor(AppColor.textDarkGrayColor(), for: .normal)
            cell.setBtn.backgroundColor = nil
        }else{
            cell.setBtn.setTitle(GoWildStrings.setAsDefault(), for: .normal)
            cell.setBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
            cell.setBtn.backgroundColor = AppColor.textDarkOrangeColor()
        }
        
        cell.setBtn.addTapGestureRecognizer { [weak self] in
            guard let self = self else {return}
            if map.isSelected {return}
            cell.setBtn.showAnimation {
                self.arrayOfMapType = self.mapOverlayVM.setMapStyle(at: indexPath.row)
                NotificationCenter.default.post(name: .mapStyleChanged, object: nil)
            }
        }
        
        return cell
    }
    
}
