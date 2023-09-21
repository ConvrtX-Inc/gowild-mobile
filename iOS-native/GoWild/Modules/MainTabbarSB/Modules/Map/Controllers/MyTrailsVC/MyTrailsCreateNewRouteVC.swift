//
//  MyTrailsCreateNewRouteVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 31/01/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit
import GoogleMaps

enum CreateNewRouteMode{
    case newRoute
    case editRoute
}

protocol MyTrailsCreateNewRouteVCDelegates: AnyObject{
    func didDeleteRouteOf(routeID: String)
    func didUpdateRouteOf(route: MyTrailsCreatedRouteData)
}

class MyTrailsCreateNewRouteVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var routeNameLbl: UILabel!
    @IBOutlet weak var routeNameTextField: UITextField!
    @IBOutlet weak var startingPointLbl: UILabel!
    @IBOutlet weak var startingLatTextField: UITextField!
    @IBOutlet weak var startingLongTextField: UITextField!
    @IBOutlet weak var endingPointLbl: UILabel!
    @IBOutlet weak var endingLatTextField: UITextField!
    @IBOutlet weak var endingLongTextField: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var zoomInBtn: UIButton!
    @IBOutlet weak var zoomOutBtn: UIButton!
    @IBOutlet weak var sourceLocationBtn: UIButton!
    @IBOutlet weak var destinationLocationBtn: UIButton!
    @IBOutlet weak var submitBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var deleteRouteVM = DeleteCreatedRouteViewModel()
    private var createNewRouteVM = CreateNewRouteViewModel()
    var newRouteUpdatePictureVM = NewRouteUpdatePictureViewModel()
    private var updateRouteVM = UpdateRouteViewModel()
    var googleRoutePathVM = GetRoutePathViewModel()
    var googleRouteImageVM = GetRouteImageViewModel()
    
    var currentTitle: String = GoWildStrings.newRoute()
    var currentRouteName: String = ""
    
    weak var delegates: MyTrailsCreateNewRouteVCDelegates?
    var mode: CreateNewRouteMode = {
        let mode: CreateNewRouteMode = .newRoute
        return mode
    }()

    ///Map Properties....
    var routeID: String = ""
    var routePath : String = ""
    var routeImageData : Data?
    var pathImage : String = ""
    var sourceLatitude : Double = 0.0
    var sourceLongitude : Double = 0.0
    var destinationLatitude : Double = 0.0
    var destinationLongitude : Double = 0.0
    var distanceMiles : Double = 0.0
    var distanceMeters : Int = 0
    var estimateTime : String = ""
    var startAddress : String = ""
    var endAddress : String = ""
    var mapZoom : Float = 16.0
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        deleteRouteVM.delegates = self
        createNewRouteVM.delegates = self
        newRouteUpdatePictureVM.delegates = self
        updateRouteVM.delegates = self
        googleRoutePathVM.delegates = self
        googleRouteImageVM.delegates = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** MyTrailsCreateNewRouteVC Deinit ***")
    }
    
    //MARK: - METHODS -

    @objc func setText(){
        titleLbl.text = self.currentTitle.capitalized
        routeNameLbl.text = GoWildStrings.routeName()
        routeNameTextField.text = self.currentRouteName
        startingPointLbl.text = GoWildStrings.startingPoint()
        endingPointLbl.text = GoWildStrings.endPoint()
        submitBtn.setTitle(GoWildStrings.submit(), for: .normal)
        self.deleteBtn.isHidden = self.mode == .newRoute ? true : false
        self.mapView.delegate = self
        if self.mode == .editRoute{
            self.setupGoogleMap()
            if !self.pathImage.isEmpty{
                if let imageURL = URL(string: self.pathImage){
                    DispatchQueue.global(qos: .background).async { [weak self] in
                        let imageData = try? Data(contentsOf: imageURL)
                        self?.routeImageData = imageData
                    }
                }
            }
        }
        self.setupLocationFields()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        routeNameLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        routeNameLbl.textColor = AppColor.appWhiteColor()
        routeNameTextField.textColor = AppColor.appWhiteColor()
        routeNameTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        startingPointLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        startingPointLbl.textColor = AppColor.appWhiteColor()
        startingLatTextField.textColor = AppColor.appWhiteColor()
        startingLatTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        startingLongTextField.textColor = AppColor.appWhiteColor()
        startingLongTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        endingPointLbl.font = Fonts.getSourceSansProBoldOf(size: 14)
        endingPointLbl.textColor = AppColor.appWhiteColor()
        endingLatTextField.textColor = AppColor.appWhiteColor()
        endingLatTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        endingLongTextField.textColor = AppColor.appWhiteColor()
        endingLongTextField.font = Fonts.getSourceSansProRegularOf(size: 14)
        self.mapView.bringSubviewToFront(self.btnStackView)
        submitBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        submitBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func setupLocationFields(){
        if self.mode == .editRoute{
            self.startingLatTextField.text = String(self.sourceLatitude)
            self.startingLongTextField.text = String(self.sourceLongitude)
            self.endingLatTextField.text = String(self.destinationLatitude)
            self.endingLongTextField.text = String(self.destinationLongitude)
        }
    }
    
    func getNewRoutePath(){
        if ((self.sourceLatitude != 0.0) && (self.destinationLatitude != 0.0)){
            let request = GetRoutePathRequest(sourceLat: self.sourceLatitude, sourceLong: self.sourceLongitude, destinationLat: self.destinationLatitude, destinationLong: self.destinationLongitude)
            self.googleRoutePathVM.getRoutePath(request: request)
        }
    }
    
    private func createNewRoute(){
        LoaderView.shared.showSpiner(inVC: self)
        let title = self.routeNameTextField.text?.removeExtraSpacingFromString() ?? ""
        self.routeNameTextField.text = title
        let startCoordinates = CreateNewRouteCoordinatesRequest(latitude: self.sourceLatitude, longitude: self.sourceLongitude)
        let endCoordinates = CreateNewRouteCoordinatesRequest(latitude: self.destinationLatitude, longitude: self.destinationLongitude)
        let request = CreateNewRouteRequest(title: title, description: title, start: startCoordinates, end: endCoordinates, distanceMiles: self.distanceMiles, distanceMeters: self.distanceMeters, estimateTime: self.estimateTime, routePath: self.routePath,startLocation: self.startAddress,endLocation: self.endAddress)
        self.createNewRouteVM.getMyTrailsCreatedRoutes(request: request)
    }
    
    private func updateRoute(){
        if !routeID.isEmpty{
            LoaderView.shared.showSpiner(inVC: self)
            let title = self.routeNameTextField.text?.removeExtraSpacingFromString() ?? ""
            self.routeNameTextField.text = title
            let startCoordinates = CreateNewRouteCoordinatesRequest(latitude: self.sourceLatitude, longitude: self.sourceLongitude)
            let endCoordinates = CreateNewRouteCoordinatesRequest(latitude: self.destinationLatitude, longitude: self.destinationLongitude)
            let request = CreateNewRouteRequest(title: title, description: title, start: startCoordinates, end: endCoordinates, distanceMiles: self.distanceMiles, distanceMeters: self.distanceMeters, estimateTime: self.estimateTime, routePath: self.routePath,startLocation: self.startAddress,endLocation: self.endAddress)
            self.updateRouteVM.updateRouteOf(routeID: self.routeID, request: request)
        }else{
            AlertControllers.showAlert(inVC: self, message: GoWildStrings.oopsSomethingWentWrong())
        }
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapDeleteBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            if !self.routeID.isEmpty{
                LoaderView.shared.showSpiner(inVC: self)
                self.deleteRouteVM.getMyTrailsCreatedRoutes(routeID: self.routeID)
            }
        }
    }
    
    @IBAction func didTapZoomInBtn(_ sender: UIButton){
        sender.showAnimation {
            if self.mapZoom < 21.0{
                self.mapZoom += 1.0
                self.mapView.animate(toZoom: self.mapZoom)
            }
        }
    }
    
    @IBAction func didTapZoomOutBtn(_ sender: UIButton){
        sender.showAnimation {
            if self.mapZoom > 2.0{
                self.mapZoom -= 1.0
                self.mapView.animate(toZoom: self.mapZoom)
            }
        }
    }
    
    @IBAction func didTapSourceLocationBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            if ((self.sourceLatitude != 0.0) && (self.sourceLongitude != 0.0)){
                self.sourceLatitude = 0.0
                self.sourceLongitude = 0.0
                self.startingLatTextField.text = ""
                self.startingLongTextField.text = ""
                self.routePath = ""
                self.setupGoogleMap()
            }
        }
    }
    
    @IBAction func didTapDestinationLocationBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            if ((self.destinationLatitude != 0.0) && (self.destinationLongitude != 0.0)){
                self.destinationLatitude = 0.0
                self.destinationLongitude = 0.0
                self.endingLatTextField.text = ""
                self.endingLongTextField.text = ""
                self.routePath = ""
                self.setupGoogleMap()
            }
        }
    }
    
    @IBAction func didTapSubmitBtn(_ sender: UIButton){
        sender.showAnimation { [weak self] in
            guard let self = self else {return}
            self.view.endEditing(true)
            if self.mode == .newRoute{
                self.createNewRoute()
            }else{
                self.updateRoute()
            }
        }
    }
    

}
