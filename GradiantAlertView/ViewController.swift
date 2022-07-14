//
//  ViewController.swift
//  GradiantAlertView
//
//  Created by Tecorb on 13/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickAlertVertical(_ sender:UIButton){

        PKGradiantAlertController.initialization().showAlertWithOkButton(aStrMessage: "Alert one show", title: "Important Message",gradiantcolor: [.red,.blue],gradientOrientation: .vertical) { (index, title) in
             print(index,title)
        }
    }
    
    @IBAction func onClickAlertHorizontal(_ sender:UIButton){
        
        PKGradiantAlertController.initialization().showAlertWithOkButton(aStrMessage: "Alert Two show", title: "Important Message",gradiantcolor: [.red,.blue],gradientOrientation: .horizontal) { (index, title) in
             print(index,title)
        }
    }
    
    @IBAction func onClickAlertVerticalOkWithCancel(_ sender:UIButton){
        PKGradiantAlertController.initialization().showAlert(aStrMessage: "Alert Three show", aCancelBtnTitle: "Cancel", aOtherBtnTitle: "Ok", title: "Important Message", gradiantcolor: [.red,.blue], gradientOrientation: .vertical) { index, title in
            print(index,title)
        }

    }
    
    @IBAction func onClickAlertHorizontalOkWithCancel(_ sender:UIButton){
        PKGradiantAlertController.initialization().showAlert(aStrMessage: "Alert Four show", aCancelBtnTitle: "Cancel", aOtherBtnTitle: "Ok", title: "Important Message", gradiantcolor: [.red,.blue], gradientOrientation: .horizontal) { index, title in
            print(index,title)
        }

    }
    


}

