//
//  loginAndRegist.swift
//  RX.SwiftExample
//
//  Created by  on 2017/3/31.
//  Copyright © 2017 rx.swift. All rights reserved.
//

import UIKit
import RxSwift
class loginAndRegist: UIViewController {

    fileprivate let imgBack:UIImageView = {
        UIImageView(frame: UIScreen.main.bounds)
    }()
    
    let loginView:LoginView = {
       LoginView(frame: UIScreen.main.bounds)
    }()
    
    let registView:RegistView = {
        RegistView(frame: UIScreen.main.bounds)
    }()
    
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        binding()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initUI() -> Void {
        self.imgBack.image = #imageLiteral(resourceName: "login_backimg")
        self.imgBack.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(imgBack)
        
        view.addSubview(loginView)
<<<<<<< HEAD
=======
//        .just
>>>>>>> ba9d34556ad1b732a3210dac186f561a4aad4f39
    }

    private func binding(){
        loginView.loginBtn.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (event) in
            print("login Action \(event)")
                
        }).disposed(by: disposeBag)
    }
    
//    private animation

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


    private let semaPhore = DispatchSemaphore.init(value: 1)
    let registlbl:UILabel = UILabel(font: 14, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), text: "Don't have an caccount?")
    private let E_mail:UILabel = UILabel(font: 13,text: "E-mail")
    private let pswlbl:UILabel = UILabel(font: 13,text: "Password")
    private let space:CGFloat = 20
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 初始化UI
    private func initUI() {
        let title:UILabel = UILabel(text: "AVITAL")
        let subTitle:UILabel = UILabel(font: 13, text: "Mobile UI Kit")
        let lineEmail = UIImageView()
        let linePsw = UIImageView()
        title.font = UIFont.boldSystemFont(ofSize:20)
        lineEmail.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        linePsw.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(linePsw)
        self.addSubview(lineEmail)
        self.addSubview(title)
        self.addSubview(subTitle)
        self.addSubview(E_mail)
        self.addSubview(pswlbl)
        self.addSubview(facebookBtn)
        self.addSubview(GoogleBtn)
        self.addSubview(registlbl)
        self.addSubview(userName)
        self.addSubview(self.psw)
        self.addSubview(loginBtn)
        //labe 和 line 是基于textfiled布局
        E_mail.snp.makeConstraints {[unowned self] (make) in
            make.center.equalTo(self.userName)
        }
        pswlbl.snp.makeConstraints {[unowned self] (make) in
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
        layoutUI()
        setCorner()
        configUI()

        psw.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext:{[unowned self] (value) in
                print("value = \(value)");
                guard let text = self.psw.text else{
                    return
                }
                if text.characters.count <= 0 {
                    self.animation(.editingDidBegin,self.psw,self.pswlbl)
                }})
            .disposed(by: disposeBag)
        psw.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext:{[unowned self] in
                guard let text = self.psw.text else{
                    return
                }
                if text.characters.count <= 0 {
                    self.animation(.editingDidEnd,self.psw,self.pswlbl)
                }})
            .disposed(by: disposeBag)
        
        userName.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext:{[unowned self] (value) in
                guard let text = self.userName.text else{
                    return
                }
                text.characters.count > 0 ? () : self.animation(.editingDidBegin,self.userName,self.E_mail)
                })
            .disposed(by: disposeBag)
        userName.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext:{[unowned self] in
                guard let text = self.userName.text else{
                    return
                }
                print("userName结束 执行了")
                text.characters.count > 0 ? () : self.animation(.editingDidEnd,self.userName,self.E_mail)
                })
            .disposed(by: disposeBag)
    }
    //MARK: Animation E-mail、psw label
    private func animation(_ controlEvent: UIControlEvents , _ textFiled:UITextField ,_ label:UILabel){
        semaPhore.wait()
        if controlEvent ==  .editingDidBegin{
            UIView.animate(withDuration: 0.4, animations: { [unowned self] in
                label.snp.remakeConstraints({(make) in
                    make.left.equalTo(textFiled)
                    make.bottom.equalTo(textFiled.snp.top)
                    })
                self.layoutIfNeeded()
            })
        }else if controlEvent ==  .editingDidEnd {
            UIView.animate(withDuration: 0.4, animations: { [unowned self] in
                label.snp.remakeConstraints({(make) in
                    make.center.equalTo(textFiled)
                    })
                self.layoutIfNeeded()
            })
        }
        semaPhore.signal()
    }
   //MARK: layoutSubViews
    private func layoutUI() -> Void {
    
        //文本框以密码框为基准
        psw.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(space)
            make.right.equalToSuperview().offset(-space)
            make.height.equalTo(40)
            make.centerY.equalToSuperview().offset(-40)
        }
        userName.snp.makeConstraints {[unowned self] (make) in
            make.left.right.height.equalTo(self.psw)
            make.bottom.equalTo(self.psw.snp.top).offset(-30)
        }
        //按钮以 regist label为基准
        registlbl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        facebookBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(space)
            make.right.equalToSuperview().offset(-UIScreen.main.bounds.size.width/CGFloat(2))
            make.bottom.equalTo(registlbl.snp.top).offset(-space)
            make.height.equalTo(44)
        }
        GoogleBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-space)
            make.height.equalTo(facebookBtn)
            make.left.equalTo(facebookBtn.snp.right)
            make.centerY.equalTo(facebookBtn)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(facebookBtn)
            make.right.equalTo(GoogleBtn)
            make.height.equalTo(facebookBtn)
            make.bottom.equalTo(facebookBtn.snp.top).offset(-space)
        }
        self.layoutIfNeeded()
    }
    //MARK: set corners
    private func setCorner(){
        let cornerSize = CGSize(width: 22, height: 22)
        facebookBtn.layerCorner(rectCorner: [.topLeft,.bottomLeft], size: cornerSize)
        GoogleBtn.layerCorner(rectCorner: [.topRight,.bottomRight], size: cornerSize)
        loginBtn.layerCorner(size: cornerSize)
    }
    //MARK: 配置属性
    private func configUI(){
        registlbl.textAlignment = .center
        userName.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        psw.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        psw.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        GoogleBtn.setTitle("Google+", for: .normal)
        GoogleBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        facebookBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        facebookBtn.setTitle("Facebook", for: .normal)
        facebookBtn.backgroundColor = #colorLiteral(red: 0.2345423996, green: 0.3002386689, blue: 0.7006446719, alpha: 1)
        GoogleBtn.backgroundColor = #colorLiteral(red: 0.8871511817, green: 0.2523205876, blue: 0.1934432387, alpha: 1)
        loginBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loginBtn.setTitle("LOGIN NOW ->", for: .normal)
        loginBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        facebookBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        GoogleBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        E_mail.font = UIFont.boldSystemFont(ofSize: 15)
        pswlbl.font = UIFont.boldSystemFont(ofSize: 15)
        registlbl.font = UIFont.boldSystemFont(ofSize: 15)
        
    }
    private func binding(){
        loginBtn.rx.tap
            .subscribe(onNext: { (control) in
                print("点击了")
                })
            .disposed(by: disposeBag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
class RegistView: UIView {
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
extension UILabel{
    convenience init(frame:CGRect = CGRect.zero , font:CGFloat = 15 ,color:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,text:String = ""){
        self.init()
        self.frame = frame ;
        self.font = UIFont.systemFont(ofSize: font) ;
        self.textColor = color ;
        self.text = text ;
        self.sizeToFit()
        
    }
}
