//
//  FaqVC.swift
//  GoWild
//
//  Created by SA - Haider Ali on 03/02/2023.
//  Copyright © 2023 Go_Wild. All rights reserved.
//

import UIKit

struct FAQModel{
    let id: String
    let question: String
    let answer: String
    var isOpen: Bool
}

class FaqVC: UIViewController {
    
    //MARK: - OUTELET -
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var helpLbl: UILabel!
    @IBOutlet weak var faqTableView: UITableView!{
        didSet{
            faqTableView.delegate = self
            faqTableView.dataSource = self
            faqTableView.estimatedRowHeight = 50.0
            faqTableView.rowHeight = UITableView.automaticDimension
            faqTableView.register(R.nib.faqCell)
        }
    }
    
    //MARK: - PROPERTIES -
    
    private var faqViewModel = GuideLineViewModel()
    private var arrayOfFaqs: [FAQModel] = []
    
    //MARK: - LIFE CYCLE -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setText()
        observers()
        faqViewModel.delegates = self
        getFaqs()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    deinit{
        Constants.printLogs("*** FaqVC Deinit ***")
    }

    //MARK: - METHODS -
    
    @objc func setText(){
        titleLbl.text = GoWildStrings.faqs().capitalized
        helpLbl.text = GoWildStrings.howCanWeHelpYou()
    }
    
    func setUI(){
        titleLbl.font = Fonts.getForegenRoughOneFontOf(size: 30)
        titleLbl.textColor = AppColor.textLightYellow()
        helpLbl.font = Fonts.getSourceSansProSemiBoldOf(size: 20)
        helpLbl.textColor = AppColor.appWhiteColor()
    }
    
    func observers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: .languageChanged, object: nil)
    }
    
    private func getFaqs(){
        LoaderView.shared.showSpiner(inVC: self)
        self.faqViewModel.getAdminGuideLinesOf(type: .faq)
    }
    
    //MARK: - ACTIONS -
    
    @IBAction func didTapBackBtn(_ sender: UIButton){
        sender.showAnimation {
            self.navigationController?.popViewController(animated: true)
        }
    }

}

//MARK: - EXTENSION FOR GUIDLINES VIEWMODEL DELEGATES -

extension FaqVC: GuideLineViewModelDelegates{
    
    func didGetAdminGuideLines(response: GuideLineResponse) {
        LoaderView.shared.hideLoader(fromVC: self)
        if let faqs = response.faq,
           !faqs.isEmpty{
            for obj in faqs {
                let faq = FAQModel(id: obj.id ?? "", question: obj.question ?? "", answer: obj.description ?? "", isOpen: false)
                self.arrayOfFaqs.append(faq)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.faqTableView.reloadData()
        }
    }
    
    func didGetAdminGuideLinesResponseWith(error: String) {
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

extension FaqVC: ListViewMethods{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfFaqs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureFaqCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.arrayOfFaqs[indexPath.row].isOpen = !self.arrayOfFaqs[indexPath.row].isOpen
        DispatchQueue.main.async { [weak self] in
            self?.faqTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - EXTENSION FOR FAQ CELL METHODS -

extension FaqVC{
    
    private func configureFaqCell(at indexPath: IndexPath) -> UITableViewCell{
        let cell = self.faqTableView.dequeueReusableCell(withIdentifier: .faqCell, for: indexPath) as! FaqCell
        
        let faq = self.arrayOfFaqs[indexPath.row]
        
        if faq.isOpen{
            cell.backView.backgroundColor = R.color.appTabbarBgColor()
            cell.backView.borderColor = .clear
            cell.dropDownImageView.image = R.image.ic_faq_down_icon()
            cell.answerLbl.isHidden = false
        }else{
            cell.backView.backgroundColor = .clear
            cell.backView.borderColor = R.color.textFieldBorderColor()
            cell.dropDownImageView.image = R.image.ic_faq_left_icon()
            cell.answerLbl.isHidden = true
        }
        
        cell.questionLbl.text = faq.question
        cell.answerLbl.text = faq.answer
        
        return cell
    }
    
}
