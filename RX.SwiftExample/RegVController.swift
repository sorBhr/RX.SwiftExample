//
//  RegVController.swift
//  RX.SwiftExample
//
//  Created by chenyihang on 2017/4/13.
//  Copyright © 2017年 rx.swift. All rights reserved.
//

import UIKit
import RxSwift

class RegVController: UIViewController {
    
    let clickButton:UIButton = {
        UIButton(type:.custom)
    }()
    private var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray;
        view.addSubview(clickButton);
        
        
        clickButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
        clickButton.setTitle("点我", for: .normal)
        clickButton.setNeedsUpdateConstraints()

        clickButton.rx.controlEvent(.touchUpInside).debounce(0.5, scheduler: MainScheduler.instance).subscribe { [unowned self](event) in
            print("reg Action \(event)")
            
        }.disposed(by: disposeBag)

    }
    
    override func viewDidLayoutSubviews() {
        
        clickButton.snp.makeConstraints {[unowned self] (make) in
            
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
