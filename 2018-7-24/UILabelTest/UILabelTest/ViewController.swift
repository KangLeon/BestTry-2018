//
//  ViewController.swift
//  UILabelTest
//
//  Created by 吉腾蛟 on 2018/7/24.
//  Copyright © 2018年 mj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //属性部分
    private let label=UILabel()
    private let testView=UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    private let testView2=UIView(frame: CGRect(x: 100, y: 400, width: 200, height: 200))
    private let button=UIButton(type: .system)
    private let imgaeview=UIImageView(frame: CGRect(x: 30, y: 100, width: 40, height: 100))
    private let textfield=UITextField(frame: CGRect(x: 20, y: 190, width: 300, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //UILabel部分
        label.text="Hello world"
        label.textColor=UIColor.black
        label.font=UIFont.systemFont(ofSize: 25.0)
        label.textAlignment = .right
        label.frame=CGRect(x: 20, y: 20, width: 150, height: 60)
        label.numberOfLines=0
        label.sizeToFit()//系统会根据label的宽度以及内容自适应一个合适的高度来显示文本
        label.lineBreakMode = .byCharWrapping
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(change))
        label.isUserInteractionEnabled=true
        label.addGestureRecognizer(tap)
        
        view.addSubview(label)
        
        //testview部分
        testView.backgroundColor=UIColor.blue
        testView.tag=1
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(act2))
        testView.addGestureRecognizer(tap2)
        
//        view.addSubview(testView)
        
        
        //testView2部分
        testView2.backgroundColor=UIColor.brown
        
//        view.addSubview(testView2)
        
        //button
        button.frame=CGRect(x: 100, y: 500, width: 100, height: 40)
        button.backgroundColor=UIColor.darkGray
        button.setTitle("Hello", for: .normal)
        button.setTitle("你好", for: .highlighted)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        view.addSubview(button)
        
        //imageview部分
        imgaeview.image=UIImage(named: "6")
        
        view.addSubview(imgaeview)
        
        //textField部分
        textfield.backgroundColor=UIColor.green
        textfield.borderStyle = .roundedRect
        textfield.clearButtonMode = .never
        textfield.placeholder="请输入用户名"
        textfield.isSecureTextEntry=true
        
        let button2 = UIButton(type: .custom)
        button2.setTitle("Test", for: .normal)
        button2.sizeToFit()
        button2.addTarget(self, action: #selector(handleRight), for: .touchUpInside)
        
        textfield.rightView=button2
        textfield.rightViewMode = .always
        textfield.delegate=self
        
        view.addSubview(textfield)
    }

    @objc func change(){
        label.text="你好,世界"
    }
    
    @objc func act2 (){
        print("我被点击了")
        print("testview tag is \(testView.tag)")
    }
    
    @objc func buttonClick (){
        print("我是按钮，我被点击了")
    }
    
    @objc func handleRight (){
        print("右边的小按钮")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    print("text field end editing")
    }
}


