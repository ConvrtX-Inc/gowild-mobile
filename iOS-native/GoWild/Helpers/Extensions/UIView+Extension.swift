//
//  UIView+Extension.swift
//  GoWild
//
//  Created by SA - Haider Ali on 07/11/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}


extension String {
    static let pisiffik: String = "PISIFFIK"
}

extension UIViewController{
    
    func navigationBarShould(hidden: Bool, animated: Bool = true) {
        navigationController?.setNavigationBarHidden(hidden, animated: animated)
    }
    
    func push(controller: UIViewController,hideBar: Bool, animated: Bool){
        controller.hidesBottomBarWhenPushed = hideBar
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func showLocationPopup(inVC: UIViewController,ok: @escaping () -> Void,cancel: @escaping () -> Void){
        let alertVC = UIAlertController(title: GoWildStrings.alert(), message: GoWildStrings.locationEnabledError(), preferredStyle: .alert)
        let okBtn = UIAlertAction(title: GoWildStrings.ok(), style: .default) { _ in
            ok()
        }
        let cancelBtn = UIAlertAction(title: GoWildStrings.cancel(), style: .cancel) { _ in
            cancel()
        }
        alertVC.addAction(okBtn)
        alertVC.addAction(cancelBtn)
        inVC.present(alertVC, animated: true)
    }
    
}

extension UIViewController{
    
    func openAppSettings(){
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

extension UIViewController{
    
    func decodePolyline(_ polylineString: String) -> [CLLocationCoordinate2D] {
        let precision = 1e5 // Adjust precision as needed
        var index = polylineString.startIndex
        let count = polylineString.count
        var coordinates = [CLLocationCoordinate2D]()
        var lat = 0.0
        var lon = 0.0

        while index < polylineString.endIndex {
            var b: UInt32 = 0
            var shift: UInt32 = 0
            var result: UInt32 = 0

            repeat {
                guard index < polylineString.endIndex else { break }
                let byte = polylineString[index].asciiValue! - 63
                b = UInt32(byte & 0x1F)
                index = polylineString.index(after: index)
                result |= (b << shift)
                shift += 5
            } while b >= 0x20

            let isNegative = (result & 1) == 1
            if isNegative {
                result = ~result
            }
            let value = Double(result) * 1e-5

            if index < polylineString.endIndex {
                lat += isNegative ? -value : value
                shift = 0
                result = 0
                repeat {
                    guard index < polylineString.endIndex else { break }
                    let byte = polylineString[index].asciiValue! - 63
                    b = UInt32(byte & 0x1F)
                    index = polylineString.index(after: index)
                    result |= (b << shift)
                    shift += 5
                } while b >= 0x20

                let isNegative = (result & 1) == 1
                if isNegative {
                    result = ~result
                }
                let value = Double(result) * 1e-5

                if index < polylineString.endIndex {
                    lon += isNegative ? -value : value
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    coordinates.append(coordinate)
                }
            }
        }
        return coordinates
    }
    
}

extension UIApplication {
    
    class func topViewController(_ base: UIViewController? =
                                    UIWindow.key?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}

extension UIImage {
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
    func rounded(with color: UIColor, width: CGFloat) -> UIImage? {
        
        guard let cgImage = cgImage?.cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : .zero, y: isPortrait ? ((size.height-size.width)/2).rounded(.down) : .zero), size: breadthSize)) else { return nil }
        
        let bleed = breadthRect.insetBy(dx: -width, dy: -width)
        let format = imageRendererFormat
        format.opaque = false
        
        return UIGraphicsImageRenderer(size: bleed.size, format: format).image { context in
            UIBezierPath(ovalIn: .init(origin: .zero, size: bleed.size)).addClip()
            var strokeRect =  breadthRect.insetBy(dx: -width/2, dy: -width/2)
            strokeRect.origin = .init(x: width/2, y: width/2)
            UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
                .draw(in: strokeRect.insetBy(dx: width/2, dy: width/2))
            context.cgContext.setStrokeColor(color.cgColor)
            let line: UIBezierPath = .init(ovalIn: strokeRect)
            line.lineWidth = width
            line.stroke()
        }
    }
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

extension UIImage {
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }
    
    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height
        
        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }
    
    private func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}



extension String {
    func containsNumbers() -> Bool {
        let numberRegEx  = ".*[0-9]+.*"
        let testCase     = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
    
    func isValid(fullName: String) -> Bool {
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^((^[a-zA-Z].*[a-zA-Z]$))$")
        return predicateTest.evaluate(with: fullName)
    }
    
    
    /// Apply strike font on text
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 1,
            range: NSRange(location: 0, length: attributeString.length))
        
        return attributeString
    }
    
    func removeExtraSpacingFromString() -> String{
        return self.components(separatedBy:.whitespacesAndNewlines).filter { $0.count > 0 }.joined(separator: " ")
    }

}

extension UIImageView {
    func cropAsCircleWithBorder(borderColor : UIColor, strokeWidth: CGFloat)
    {
        var radius = min(self.bounds.width, self.bounds.height)
        var drawingRect : CGRect = self.bounds
        drawingRect.size.width = radius
        drawingRect.origin.x = (self.bounds.size.width - radius) / 2
        drawingRect.size.height = radius
        drawingRect.origin.y = (self.bounds.size.height - radius) / 2
        
        radius /= 2
        
        var path = UIBezierPath(roundedRect: drawingRect.insetBy(dx: strokeWidth/2, dy: strokeWidth/2), cornerRadius: radius)
        let border = CAShapeLayer()
        border.fillColor = UIColor.clear.cgColor
        border.path = path.cgPath
        border.strokeColor = borderColor.cgColor
        border.lineWidth = strokeWidth
        self.layer.addSublayer(border)
        
        path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension String {
    func toImage() -> UIImage {
        return UIImage(named: self) ?? UIImage()
    }
}

extension UINavigationController {
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}

extension UIImage {
    func flipHorizontally() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        context.translateBy(x: self.size.width/2, y: self.size.height/2)
        context.scaleBy(x: -1.0, y: 1.0)
        context.translateBy(x: -self.size.width/2, y: -self.size.height/2)
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIButton {
    
    func centerVertically(padding: CGFloat = 2.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
  
}

extension UISegmentedControl {
    
}

extension UIColor {
    static let appLightGreenColor = UIColor.init(red: 142/255, green: 245/255, blue: 12/255, alpha: 1)
    static let appYellowColor = UIColor.init(red: 215/255, green: 213/255, blue: 0/255, alpha: 1)
    static let appBoxColor = UIColor.init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
    static let appBackgroundColor = UIColor.init(red: 14/255, green: 14/255, blue: 14/255, alpha: 1)
    static let appLightRedBgColor = UIColor.init(red: 235/255, green: 87/255, blue: 87/255, alpha: 0.1)
}

extension CGColor {
    static let appLightGreenCgColor = UIColor.init(red: 142/255, green: 245/255, blue: 12/255, alpha: 1).cgColor
    static let appYellowCgColor = UIColor.init(red: 215/255, green: 213/255, blue: 0/255, alpha: 1).cgColor
    static let appBoxCgColor = UIColor.init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1).cgColor
    static let appBackgroundCgColor = UIColor.init(red: 14/255, green: 14/255, blue: 14/255, alpha: 1).cgColor
    static let appLightRedBgCgColor = UIColor.init(red: 235/255, green: 87/255, blue: 87/255, alpha: 0.1).cgColor
}

extension UINavigationController {
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }
    
    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }
}

extension String {
    var getPrefix: String {
        
        let newString = self.components(separatedBy: " ").filter { !$0.isEmpty }.reduce("") { ($0 == "" ? "" : "\($0.first!)") + ($1 == "" ? "\($0.last!)" : "\($1.first!)") }
        
        return newString
    }
}


extension String {
    
    func getDateObjectFromString() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        //2019-11-30 18:30:00
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.date(from: self)!
    }
    
    func getDayHourMinuteSecond()->String
    {
        let datefrmter = DateFormatter()
        datefrmter.timeZone = TimeZone(identifier: "UTC")
        datefrmter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        if let dateHere = datefrmter.date(from: self){
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: "UTC")!
            
            let component  = calendar.dateComponents([.day, .hour, .minute, .second], from: Date(), to: dateHere)
            let timeString = "\(component.day ?? 00):\(component.hour ?? 00):\(component.minute ?? 00):\(component.second ?? 00)"
            print("Time String = \(timeString)")
            return timeString
        }
        else{
            return "00:00:00:00"
        }
    }
    
    //MARK: - POST FEED DATE FORMAT...
    
    static let userDateOfBirthFormat : String = "yyyy-MM-dd"
    static let postFeedDateFormat : String = "dd MMM yyyy HH:mm"
    static let eWavierDateFormat : String = "dd MMM, yyyy"
    static let supportTicketDate : String = "MMMM dd, yyyy | HH:mm"
    static let UTCFormat : String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    static let LocalFormat : String = "yyyy-MM-dd HH:mm:ss"
    static let TreasureWildFeedDateFormat : String = "MM/dd/yyyy"
    static let TreasureWildFeedTimeFormat : String = "HH:mm"
    static let TreasureWildEventStartDayDateFormat : String = "dd"
    static let TreasureWildEventStartMonthDateFormat : String = "MM"
    static let notificationDateFormat : String = "MMM dd"
    
    //MARK: - Convert UTC To Local Date by passing date formats value
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    //MARK: - Convert Local To UTC Date by passing date formats value
    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    
    func getDayHourMinuteSecondFrom()->String
    {
        let datefrmter = DateFormatter()
        datefrmter.timeZone = TimeZone(identifier: "UTC")
        datefrmter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        if let dateHere = datefrmter.date(from: self){
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: "UTC")!
            
            let component  = calendar.dateComponents([.hour, .minute], from: Date(), to: dateHere)
            let timeString = "\(component.hour ?? 00):\(component.minute ?? 00)"
            print("Time String = \(timeString)")
            return timeString
        }
        else{
            return "00:00"
        }
    }
    
    
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isContainOnlyNumber: Bool {
        let cvcFormat = "^[0-9]+$"
        let cvcPredicate = NSPredicate(format:"SELF MATCHES %@", cvcFormat)
        return cvcPredicate.evaluate(with: self)
    }
    
    var isValidCVC: Bool {
        let cvcFormat = "^[0-9]{3, 4}$"
        let cvcPredicate = NSPredicate(format:"SELF MATCHES %@", cvcFormat)
        return cvcPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        if self.count < 8 {
            return false
        }
        return true
    }
    
    func isValidWithout(nameString: String) -> Bool {
        
        if nameString.count > 1 && nameString.count < 16 {
            if nameString.containsNumbers() == false{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
        
    }
    
    func isValid(nameString: String) -> Bool {
        guard nameString.count > 2, nameString.count < 15 else { return false }

        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: nameString)
    }
    
    func isValidAbout(nameString: String) -> Bool {
        guard nameString.count > 2, nameString.count < 100 else { return false }

        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z][A\\p{L}z'\\s]{0,100}$")
        return predicateTest.evaluate(with: nameString)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    var convert24HourTo12hour:String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "h:mm a"
        let Date12 = dateFormatter.string(from: date!)
        return Date12
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSMutableAttributedString()
        }
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 0.90, y: 0.90)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}

extension UIView {

    func roundCorners(corners:UIRectCorner, radius: CGFloat) {

        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    func zoomInZoomOut(_ duration: Double = 0.8) {
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat,.autoreverse], animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
}

extension UIView {
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}

extension UILabel {

    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }

        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
}


extension UICollectionReusableView {
    class func loadViewFromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}

class SelfSizingCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isScrollEnabled = false
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}


extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}



extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension Data {
    func getSizeInMB() -> Double {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self.count)).replacingOccurrences(of: ",", with: ".")
        if let double = Double(string.replacingOccurrences(of: " MB", with: "")) {
            return double
        }
        return 0.0
    }
}


extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.opacity = 0.40
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}


extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}



struct ImageCompressor {
    static func compress(image: UIImage, maxByte: Int,
                         completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let currentImageSize = image.jpegData(compressionQuality: 1.0)?.count else {
                return completion(nil)
            }
        
            var iterationImage: UIImage? = image
            var iterationImageSize = currentImageSize
            var iterationCompression: CGFloat = 1.0
        
            while iterationImageSize > maxByte && iterationCompression > 0.01 {
                let percantageDecrease = getPercantageToDecreaseTo(forDataCount: iterationImageSize)
            
                let canvasSize = CGSize(width: image.size.width * iterationCompression,
                                        height: image.size.height * iterationCompression)
                UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
                defer { UIGraphicsEndImageContext() }
                image.draw(in: CGRect(origin: .zero, size: canvasSize))
                iterationImage = UIGraphicsGetImageFromCurrentImageContext()
            
                guard let newImageSize = iterationImage?.jpegData(compressionQuality: 1.0)?.count else {
                    return completion(nil)
                }
                iterationImageSize = newImageSize
                iterationCompression -= percantageDecrease
            }
            completion(iterationImage)
        }
    }

    private static func getPercantageToDecreaseTo(forDataCount dataCount: Int) -> CGFloat {
        switch dataCount {
        case 0..<3000000: return 0.05
        case 3000000..<10000000: return 0.1
        default: return 0.2
        }
    }
}

extension UIImage{
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        let megaByte = 1000.0
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > megaByte { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.5),
                  let imageData = resizedImage.pngData() else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        }
        
        return resizingImage
    }
    
    func compressImage(with maxSizeInBytes: Int ) -> UIImage? {
        if maxSizeInBytes < 0 {
            return nil
        }
        var currentImage:UIImage? = self
        var divideQuality:CGFloat = 1.0
        var imageData = self.jpegData(compressionQuality:divideQuality )
        while imageData!.count > maxSizeInBytes {
            divideQuality = divideQuality/2
            imageData = currentImage?.jpegData(compressionQuality: divideQuality)
        }
        guard let data = imageData else {
            return nil
        }
        currentImage = UIImage(data: data)
        guard let currentImg = currentImage,let imgData = currentImg.jpegData(compressionQuality: divideQuality) else {return nil}
        return UIImage(data: imgData)
    }
    
}




extension UIView {

    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    fileprivate typealias Action = (() -> Void)?


    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }


    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }


    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }

}


extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}



extension UIImageView
{
    func addBlurEffect(imageView: UIImageView)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        imageView.addSubview(blurEffectView)
    }
}

extension Int {

    func secondsToTime() -> String {

        let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)

        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(h_string):\(m_string):\(s_string)"
    }
    
    func secondsToMinAndSeconds() -> String {

        let (m,s) = ((self % 3600) / 60, (self % 3600) % 60)

        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(m_string):\(s_string)"
    }
}


extension String {
    func toInt() -> Int {
        if let myNumber = NumberFormatter().number(from: self) {
            let myInt = myNumber.intValue
            // do what you need to do with myInt
            return myInt
        } else {
            // what ever error code you need to write
            return 0
        }
    }
    
    func replacingOccurrencesOfWhiteSpaces() -> String{
        self.replacingOccurrences(of: " ", with: "")
    }
    
}



extension Locale {
    static var preferredLanguageIdentifier: String {
        let id = Locale.preferredLanguages.first!
        let comps = Locale.components(fromIdentifier: id)
        return comps.values.first!
    }

    static var preferredLanguageLocalizedString: String {
        let id = Locale.preferredLanguages.first!
        return Locale.current.localizedString(forLanguageCode: id)!
    }
}



extension UIApplication {
    class var topViewController: UIViewController? { return getTopViewController() }
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController { return getTopViewController(base: nav.visibleViewController) }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController { return getTopViewController(base: selected) }
        }
        if let presented = base?.presentedViewController { return getTopViewController(base: presented) }
        return base
    }

    private class func _share(sourceView: UIButton,_ data: [Any],
                              applicationActivities: [UIActivity]?,
                              setupViewControllerCompletion: ((UIActivityViewController) -> Void)?) {
        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: nil)
        setupViewControllerCompletion?(activityViewController)
        activityViewController.popoverPresentationController?.sourceView = sourceView
        UIApplication.topViewController?.present(activityViewController, animated: true, completion: nil)
    }

    class func share(sourceView: UIButton, _ data: Any...,
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(sourceView: sourceView, data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
    class func share(sourceView: UIButton,_ data: [Any],
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(sourceView: sourceView, data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
}

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        datePicker.maximumDate = Date()
        
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
          datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}


extension URL{
    
    func fileSize() -> Double{
        do {
            let resources = try self.resourceValues(forKeys:[.fileSizeKey])
            let fileSize = resources.fileSize!
            let sizeInStr = String(format: "%.2f", (Double(fileSize) * (0.000001)))
            return (Double(sizeInStr) ?? 0.0)
        } catch {
            print("Error: \(error)")
        }
        return 0.0
    }
    
}

extension String{
    
    func parseToInt() -> Int? {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
    
    func convertToDate() -> String {
     
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dt = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMM"
            let formatedStringDate = dateFormatter.string(from: dt)
                return formatedStringDate
        }
      
     
        return ""
    }
    
}


extension Dictionary{
    
    func convertBackendErrorToString() -> String{
        var responseError : String = ""
        for (_ , value) in self{
            responseError = value as? String ?? ""
        }
        return responseError
    }
    
}
