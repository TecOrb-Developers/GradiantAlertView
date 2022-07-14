

import UIKit
import Foundation

class PKGradiantAlertController: UIViewController {
    
    // MARK: Private Properties
    
    private var strAlertTitle = String()
    private var strAlertText = String()
    private var btnCancelTitle:String?
    private var btnOtherTitle:String?
    
    private let btnOtherColor  = UIColor.white//UIColor(red: 0/255.0, green: 120.0/255.0, blue: 108.0/255.0, alpha: 1.0)
    private let btnCancelColor = UIColor.white//UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
     // MARK: Public Properties
    @IBOutlet var viewAlert: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblAlertText: UILabel?
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnOther: UIButton!
    @IBOutlet var btnOK: UIButton!
    @IBOutlet var viewAlertBtns: UIView!
    @IBOutlet var alertWidthConstraint: NSLayoutConstraint!
    public var gradiantColours: [UIColor] = [UIColor(red: 22.0/255.0, green: 78.0/255.0, blue: 161.0/255.0, alpha: 1.0), UIColor(red: 150.0/255.0, green: 77.0/255.0, blue: 156.0/255.0, alpha: 1.0)]
    public var gradientOrientation: GradientOrientation = .horizontal
    
    // MARK: AlertController Completion handler
    typealias alertCompletionBlock = ((Int, String) -> Void)?
    private var block : alertCompletionBlock?
    
    // MARK: PKAlertController Initialization
    
    static func initialization() -> PKGradiantAlertController
    {
        let alertController = PKGradiantAlertController(nibName: "PKGradiantAlertController", bundle: nil)
        return alertController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPKGradiantAlertController()
        btnOK.setTitle("Okay", for: .normal)
    }
    
    override func viewWillLayoutSubviews() {
        viewAlert.applyGradient(withColours:gradiantColours, gradientOrientation: gradientOrientation)
    }
    
    // MARK: PKAlertController Private Functions
    
    // MARK: Inital View Setup
    private func setupPKGradiantAlertController(){
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.1
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(visualEffectView, at: 0)
        preferredAlertWidth()
        viewAlert.layer.cornerRadius  = 10.0
        viewAlert.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
        viewAlert.layer.shadowColor   = UIColor(white: 0.0, alpha: 1.0).cgColor
        viewAlert.layer.shadowOpacity = 0.3
        viewAlert.layer.shadowRadius  = 10.0
        lblTitle.text   = strAlertTitle
        lblAlertText?.text   = strAlertText
        
        if let aCancelTitle = btnCancelTitle {
            btnCancel.setTitle(aCancelTitle, for: .normal)
            btnOK.setTitle(nil, for: .normal)
            btnCancel.setTitleColor(btnCancelColor, for: .normal)
        } else {
            btnCancel.isHidden  = true
        }
        
        if let aOtherTitle = btnOtherTitle {
            btnOther.setTitle(aOtherTitle, for: .normal)
            btnOK.setTitle(nil, for: .normal)
            btnOther.setTitleColor(btnOtherColor, for: .normal)
        } else {
            btnOther.isHidden  = true
        }
        
        if btnOK.title(for: .normal) != nil {
            btnOK.setTitleColor(btnOtherColor, for: .normal)
        } else {
            btnOK.isHidden  = true
        }
    }
    
    // MARK: Setup different widths for iPad and iPhone
    private func preferredAlertWidth()
    {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            alertWidthConstraint.constant = 280.0
        case .pad:
            alertWidthConstraint.constant = 340.0
        case .unspecified: break
        case .tv: break
        case .carPlay: break
        case .mac: break
        @unknown default:
            break
        }
    }
    
    // MARK: Create and Configure Alert Controller
    private func configure(message:String, btnCancelTitle:String?, btnOtherTitle:String?,title:String,gradiantcolor:[UIColor],gradientOrientation:GradientOrientation)
    {
        self.strAlertText          = message
        self.btnCancelTitle     = btnCancelTitle
        self.btnOtherTitle    = btnOtherTitle
        self.strAlertTitle = title
        self.gradiantColours = gradiantcolor
        self.gradientOrientation = gradientOrientation
    }
    
    // MARK: Show Alert Controller
    private func show()
    {
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window, let rootViewController = window?.rootViewController {
            
            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }
            
            topViewController.addChild(self)
            topViewController.view.addSubview(view)
            viewWillAppear(true)
            didMove(toParent: topViewController)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.alpha = 0.0
            view.frame = topViewController.view.bounds
            
            viewAlert.alpha     = 0.0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.view.alpha = 1.0
            }, completion: nil)
            
            viewAlert.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-10)
            UIView.animate(withDuration: 0.2 , delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                self.viewAlert.alpha = 1.0
                self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0))
            }, completion: nil)
        }
    }
    
    // MARK: Hide Alert Controller
    private func hide(completion:@escaping (_ done: Bool)->Void){
        self.view.endEditing(true)
        self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.viewAlert.alpha = 0.0
            self.viewAlert.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-5)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseIn, animations: { () -> Void in
            self.view.alpha = 0.0
            
        }) { (completed) -> Void in
            
            self.view.removeFromSuperview()
            self.removeFromParent()
            completion(true)
        }
    }
    
    // MARK:  UIButton Clicks
    
    @IBAction func btnCancelTapped(sender: UIButton) {
        self.hide { (done) in
            if done{
                self.block!!(0,self.btnCancelTitle!)
            }
        }
    }
    
    @IBAction func btnOtherTapped(sender: UIButton) {
        self.hide { (done) in
            if done{
                self.block!!(1,self.btnOtherTitle!)
                
            }
        }
    }
    
    @IBAction func btnOkTapped(sender: UIButton)
    {
        self.hide { (done) in
            if done{
                self.block!!(0,"OK")
                
            }
        }
    }
    
    public func showAlert( aStrMessage:String,aCancelBtnTitle:String?,aOtherBtnTitle:String?,title:String ,gradiantcolor:[UIColor],gradientOrientation:GradientOrientation,completion : alertCompletionBlock){
        configure( message: aStrMessage, btnCancelTitle: aCancelBtnTitle, btnOtherTitle: aOtherBtnTitle, title: title,gradiantcolor: gradiantcolor,gradientOrientation: gradientOrientation)
        show()
        block = completion
    }
    
    
    public func showAlertWithOkButton( aStrMessage:String,title:String,gradiantcolor:[UIColor],gradientOrientation:GradientOrientation,
                                       completion : alertCompletionBlock){
        configure(message: aStrMessage, btnCancelTitle: nil, btnOtherTitle: nil, title: title,gradiantcolor:gradiantcolor,gradientOrientation:gradientOrientation)
        show()
        block = completion
    }
}


extension UIView{
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation,locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        gradient.locations = locations
        if let glayer = self.layer.sublayers?.first as? CAGradientLayer{
            glayer.removeFromSuperlayer()
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
}


typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint: CGPoint {
        return points.startPoint
    }
    
    var endPoint: CGPoint {
        return points.endPoint
    }
    
    var points: GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint.init(x: 0.0, y: 1.0), CGPoint.init(x: 1.0, y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 1, y: 1))
        case .horizontal:
            return (CGPoint.init(x: 0.0, y: 0.5), CGPoint.init(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 0.0, y: 1.0))
        }
    }
}
