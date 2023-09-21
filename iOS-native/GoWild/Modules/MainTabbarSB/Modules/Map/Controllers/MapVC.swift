//
//  MapVC.swift
//  GoWild
//
//  Created by APPLE on 11/14/22.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit

struct Maps{
    let mapImage: UIImage?
    let mapTitle: String
}

class MapVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mapTableView: UITableView!{
        didSet{
            mapTableView.delegate = self
            mapTableView.dataSource = self
            mapTableView.register(R.nib.mapCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private let mapList : [Maps] = [
        Maps(mapImage: R.image.ic_map_1_image(), mapTitle: GoWildStrings.treasureMap().capitalized),
        Maps(mapImage: R.image.ic_map_2_image(), mapTitle: GoWildStrings.runWild().capitalized)
    ]
    
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
        titleLbl.text = GoWildStrings.map()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func navigateToTreasureWildVC(){
        guard let mapDetailVC = R.storyboard.mapSB.treasureWildVC() else {return}
        self.push(controller: mapDetailVC, hideBar: true, animated: true)
    }
    
    private func navigateToRunWildVC(){
        if LocationManager.shared.userDeniedLocation{
            self.showLocationPopup(inVC: self) {
                self.openAppSettings()
            } cancel: {
                self.dismiss(animated: true)
            }
        }else{
            guard let runWildVC = R.storyboard.runWildSB.runWildVC() else {return}
            self.push(controller: runWildVC, hideBar: true, animated: true)
        }
    }
    
    private func navigateToMyTrailsVC(){
        guard let myTrailsVC = R.storyboard.myTrailsSB.myTrailsVC() else {return}
        self.push(controller: myTrailsVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -

    

}


//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension MapVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureMapCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            self.navigateToTreasureWildVC()
        case 1:
            self.navigateToRunWildVC()
        case 2:
            self.navigateToMyTrailsVC()
        default:
            Constants.printLogs("*********************")
        }
        
    }
    
}

//MARK: - EXTENSION FOR MAP CELL -

extension MapVC{
    
    private func configureMapCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = mapTableView.dequeueReusableCell(withIdentifier: .mapCell, for: indexPath) as! MapCell
        
        let map = self.mapList[indexPath.row]
        cell.mapImageView.image = map.mapImage
        cell.titleLbl.text = map.mapTitle
        
        return cell
    }
    
}
