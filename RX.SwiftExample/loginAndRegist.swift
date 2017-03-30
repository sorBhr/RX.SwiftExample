//
//  loginAndRegist.swift
//  RX.SwiftExample
//
//  Created by  on 2017/3/31.
//  Copyright © 2017 rx.swift. All rights reserved.
//

import UIKit
class loginAndRegist: UIViewController {

    fileprivate let imgBack:UIImageView = {
        UIImageView(frame: UIScreen.main.bounds)
    }()
    
    let loginView:LoginView = {
       LoginView(frame: UIScreen.main.bounds)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initUI() -> Void {
        self.imgBack.image = UIImage(named: "")
        self.imgBack.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(imgBack)
        view.addSubview(loginView)
    }
    private func binding(){
    
  
    }

}
class LoginView: UIView {
    
    let loginBtn:UIButton = {
        UIButton(type: .custom)
    }()
    
    let userName:UITextField = {
        UITextField()
    }()
    
    let psw:UITextField = {
        UITextField()
    }()
    
    let facebookBtn:UIButton = {
        UIButton(type: .custom)
    }()

    let GoogleBtn:UIButton = {
        UIButton(type: .custom)
    }()

    let registBtn:UIButton = {
        UIButton(type: .custom)
    }()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 初始化UI
    private func initUI() {
        let title:UILabel = UILabel(text: "AVITAL")
        let subTitle:UILabel = UILabel(font: 13, text: "Mobile UI Kit")
        let E_mail:UILabel = UILabel(font: 13,text: "E-mail")
        let psw:UILabel = UILabel(font: 13,text: "Password")
        let lineEmail = UIImageView()
        let linePsw = UIImageView()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        lineEmail.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        linePsw.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(linePsw)
        self.addSubview(lineEmail)
        self.addSubview(title)
        self.addSubview(subTitle)
        self.addSubview(E_mail)
        self.addSubview(psw)
        self.addSubview(facebookBtn)
        self.addSubview(GoogleBtn)
        self.addSubview(registBtn)
        self.addSubview(userName)
        self.addSubview(self.psw)
        self.addSubview(loginBtn)
        //labe 和 line 是基于textfiled布局
        E_mail.snp.makeConstraints {[unowned self] (make) in
            make.center.equalTo(self.userName)
        }
        psw.snp.makeConstraints {[unowned self] (make) in
            make.center.equalTo(self.psw)
        }
        lineEmail.snp.makeConstraints {[unowned self] (make) in
            make.left.right.bottom.equalTo(self.userName)
            make.height.equalTo(1.5)
        }
        linePsw.snp.makeConstraints {[unowned self] (make) in
            make.left.right.bottom.equalTo(self.psw)
            make.height.equalTo(lineEmail)
        }
        //title 和 subtitle 基于父视图布局
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(84)
        }
        subTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(title.snp.bottom)
        }
        userName.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext:{[unowned self] in
                UIView.animate(withDuration: 0.3, animations: {
                    E_mail.snp.remakeConstraints({[unowned self] (make) in
                        make.left.equalTo(lineEmail)
                        make.bottom.equalTo(self.userName.snp.top).offset(-8)
                        })
                    self.layoutIfNeeded()})
                })
//        userName.rx.controlEvent(.editingDidEnd)
//            .subscribe(onNext:{[unowned self] in
//                UIView.animate(withDuration: 0.8, animations: {
//                    E_mail.snp.remakeConstraints({[unowned self] (make) in
//                        make.left.equalTo(lineEmail)
//                        make.bottom.equalTo(self.userName.snp.top).offset(-10)
//                        })
//                    self.layoutIfNeeded()
//                })
//                })


        layoutUI()
    }
    //MARK: layoutSubViews
   private func layoutUI() -> Void {
    
        //文本框以密码框为基准
        psw.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        userName.snp.makeConstraints {[unowned self] (make) in
            make.left.right.height.equalTo(self.psw)
            make.bottom.equalTo(self.psw.snp.top).offset(-30)
        }
    
    }
}
class registView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("释放了")
    }
    
}
extension UILabel {
    convenience init(frame:CGRect = CGRect.zero , font:CGFloat = 15 ,color:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,text:String = ""){
        self.init()
        self.frame = frame ;
        self.font = UIFont.systemFont(ofSize: font) ;
        self.textColor = color ;
        self.text = text ;
        self.sizeToFit()
        
    }
}
