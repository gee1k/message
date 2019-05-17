//
//  Message.swift
//  PostLocationWeb
//
//  Created by Sue on 2019/5/10.
//  Copyright © 2019 eshore. All rights reserved.
//

import Foundation
import UIKit

class LoadingMessage: UIView{
    private var messageLabel: UILabel!
    private func configViews(message: String){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .white
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        self.addSubview(indicator)
        self.addSubview(messageLabel)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let viewMap = ["indicator": indicator, "messageLabel": messageLabel]
        
        let con1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[indicator]-20-[messageLabel]-|", options: [], metrics: nil, views: viewMap)
        addConstraints(con1)
        let con2 = NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        addConstraint(con2)
        let con3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[messageLabel(==100)]-|", options: [], metrics: nil, views: viewMap)
        addConstraints(con3)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViews(message: "Label")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configViews(message: "Label")
    }
    
    func setMessage(_ msg: String){
        messageLabel.text = msg
    }
    
    func close() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (stop) in
            self.removeFromSuperview()
        }
    }
}

extension UIViewController{
    func toast(_ msg: String) {
        guard let fatherView = UIApplication.shared.keyWindow else {
            return
        }
        
        let msgLabel = UILabel()
        msgLabel.numberOfLines = 0
        msgLabel.text = msg
        msgLabel.font = UIFont.systemFont(ofSize: 14)
        msgLabel.textColor = .white
        msgLabel.textAlignment = .center
        
        let container = UIView()
        container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = true
        
        fatherView.addSubview(container)
        container.addSubview(msgLabel)
        
        msgLabel.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict = ["msgLabel": msgLabel, "container": container]
        let con1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=20)-[container]", options: [], metrics: nil, views: viewsDict)
        let con2 = NSLayoutConstraint.constraints(withVisualFormat: "V:[container]-100-|", options: [], metrics: nil, views: viewsDict)
        let con0 = NSLayoutConstraint(item: container, attribute: .centerX, relatedBy: .equal, toItem: fatherView, attribute: .centerX, multiplier: 1, constant: 0)
        fatherView.addConstraints(con1)
        fatherView.addConstraints(con2)
        fatherView.addConstraint(con0)
        
        let con3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[msgLabel(>=100)]-|", options: [], metrics: nil, views: viewsDict)
        let con4 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[msgLabel]-|", options: [], metrics: nil, views: viewsDict)
        container.addConstraints(con3)
        container.addConstraints(con4)
        
        UIView.animate(withDuration: 0.2, delay: 0.8, options: .curveEaseInOut, animations: {
            container.alpha = 0
        }) { (stop) in
            container.removeFromSuperview()
        }
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(actionOk)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func loading(message: String) -> LoadingMessage?{
        guard let fatherView = UIApplication.shared.keyWindow else{
            return nil
        }
        let load = LoadingMessage()
        load.setMessage(message)
        fatherView.addSubview(load)
        load.translatesAutoresizingMaskIntoConstraints = false
        
        let con1 = NSLayoutConstraint(item: load, attribute: .centerY, relatedBy: .equal, toItem: fatherView, attribute: .centerY, multiplier: 1, constant: 0)
        fatherView.addConstraint(con1)
        let con2 = NSLayoutConstraint(item: load, attribute: .centerX, relatedBy: .equal, toItem: fatherView, attribute: .centerX, multiplier: 1, constant: 0)
        fatherView.addConstraint(con2)
        return load
    }
}

