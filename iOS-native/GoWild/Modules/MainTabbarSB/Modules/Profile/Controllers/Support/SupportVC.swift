//
//  SupportVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 16/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import UIKit
import Kingfisher

class SupportVC: UIViewController {
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var supportTableView: UITableView!{
        didSet{
            supportTableView.delegate = self
            supportTableView.dataSource = self
            supportTableView.register(R.nib.supportCell)
        }
    }
    @IBOutlet weak var sendBtn: LoadingButton!
    
    //MARK: - PROPERTIES -
    
    private var supportTicketVM = SupportTicketListViewModel()
    private var arrayOfTickets : [SupportTicketList] = []
    
    //MARK: - LIFE CYCLES -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        supportTicketVM.delegates = self
        getTicketList()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** SupportVC Deinit ***")
    }
    
    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.support().capitalized
        helpLbl.text = GoWildStrings.howCanWeHelpYou()
        sendBtn.setTitle(GoWildStrings.sendNewTicket(), for: .normal)
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        helpLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 20)
        helpLbl.textColor = AppColor.appWhiteColor()
        sendBtn.titleLabel?.font = Fonts.getSourceSansProBoldOf(size: 16)
        sendBtn.setTitleColor(AppColor.appWhiteColor(), for: .normal)
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getTicketList(){
        LoaderView.shared.showSpiner(inVC: self)
        self.supportTicketVM.getTicketsList()
    }
    
    private func navigateToSupportMessageVC(with ticketID: String,status: String){
        guard let supportMessageVC = R.storyboard.supportSB.supportMessageVC() else {return}
        supportMessageVC.ticketID = ticketID
        supportMessageVC.status = status
        self.push(controller: supportMessageVC, hideBar: true, animated: true)
    }
    
    private func navigateToNewTicketVC(){
        guard let newTicketVC = R.storyboard.supportSB.newTicketVC() else {return}
        newTicketVC.delegates = self
        self.push(controller: newTicketVC, hideBar: true, animated: true)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapSendBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigateToNewTicketVC()
        }
    }

}

//MARK: - EXTENSION FOR HomeRetrieveRouteViewModelDelegates -

extension SupportVC: SupportTicketListViewModelDelegates{
    
    func didGetTicketList(response: SupportTicketListResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let list = response.data{
            if !list.isEmpty{
                self.arrayOfTickets = list.reversed()
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.supportTableView.reloadData()
        }
    }
    
    func didGetTicketListResponseWith(error: String) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error)
    }
    
    func didReceiveServer(error: [String]?, type: String, indexPath: Int) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? "")
    }
    
    func didReceiveUnauthentic(error: [String]?) {
        LoaderView.shared.hideLoader(fromVC: self)
        AlertControllers.showAlert(inVC: self, message: error?.first ?? ""){
            RouterNavigation.shared.logoutUserIsUnAutenticated()
        }
    }
    
}


//MARK: - EXTENSION FOR LIST VIEW METHODS -

extension SupportVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfTickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureSupportCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ticketID = self.arrayOfTickets[indexPath.row].id else {return}
        self.navigateToSupportMessageVC(with: ticketID,status: self.arrayOfTickets[indexPath.row].status ?? "")
    }
    
}

//MARK: - EXTESNION FOR CELL METHODS -

extension SupportVC{
    
    private func configureSupportCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.supportTableView.dequeueReusableCell(withIdentifier: .supportCell, for: indexPath) as! SupportCell
        
        let ticket = self.arrayOfTickets[indexPath.row]
        if let imageURL = URL(string: "\(UserManager.shared.getBaseURL())\(ticket.user?.userPhoto ?? "")"){
            cell.logoImageView.kf.indicatorType = .activity
            cell.logoImageView.kf.setImage(with: imageURL, placeholder: R.image.ic_user_placeholder_image())
        }
        cell.trackNmbLbl.text = ticket.id?.prefix(8).description.capitalized
        cell.descriptionLbl.text = ticket.subject
        
        if let createdDate = ticket.createdDate{
            cell.dateLbl.text = Utils.shared.getSupportTicket(date: createdDate)
        }
        
        if let status = ticket.status{
            if status == TicketStatusEnum.completed.rawValue{
                cell.statusLbl.backgroundColor = AppColor.appTabbarBgColor()
                cell.statusLbl.text = GoWildStrings.completed()
            }else if status == TicketStatusEnum.pending.rawValue{
                cell.statusLbl.backgroundColor = AppColor.appYellowColor()
                cell.statusLbl.text = GoWildStrings.pending()
            }else{
                cell.statusLbl.backgroundColor = AppColor.textDarkGrayColor()
                cell.statusLbl.text = GoWildStrings.onHold()
            }
        }else{
            cell.statusLbl.backgroundColor = AppColor.appYellowColor()
            cell.statusLbl.text = GoWildStrings.pending()
        }
        
        return cell
    }
    
}


//MARK: - EXTENSION FOR CreateTicketDelegate -

extension SupportVC: CreateTicketDelegate{
    
    func didNewTicketCreated(ticket: SupportTicketList) {
        self.arrayOfTickets.insert(ticket, at: 0)
        DispatchQueue.main.async { [weak self] in
            self?.supportTableView.reloadData()
        }
    }
    
}
