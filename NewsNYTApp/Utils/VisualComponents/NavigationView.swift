//
//  NavigationView.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 28/11/24.
//

import UIKit

class NavigationView: UIView {
    
    public lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var btnLeft: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private var navigation: UINavigationController?

    public init() {
        super.init(frame: CGRect.zero)
        
        buildUIComponents()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUIComponents() {
        
        containerView.addSubview(btnLeft)
        containerView.addSubview(lbTitle)
        
        self.addSubview(containerView)
    }
    
    private func buildConstraints() {
        let topMargin = getStatusBarHeight()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: topMargin),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 60.0),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            btnLeft.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0),
            btnLeft.heightAnchor.constraint(equalToConstant: 40.0),
            btnLeft.widthAnchor.constraint(equalToConstant: 40.0),
            btnLeft.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            lbTitle.leadingAnchor.constraint(equalTo: btnLeft.trailingAnchor),
            lbTitle.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50.0)
        ])
    }
    
    public func configComponents(navigation: UINavigationController?,
                                 title: String,
                                 titleColor: UIColor = UIColor.white,
                                 titleFont: UIFont  = UIFont.boldSystemFont(ofSize: 20.0),
                                 backgroundColor: UIColor = UIColor.skyBlue,
                                 iconLeftButton: String? = "icon_leftArrow") {
        
        self.navigation = navigation
        self.backgroundColor = backgroundColor
        self.containerView.backgroundColor = backgroundColor
        
        lbTitle.text = title
        lbTitle.textColor = titleColor
        lbTitle.font = titleFont
        
        if let iconLeft = iconLeftButton {
            let imageButton = UIImage(named: iconLeft)
            btnLeft.setImage(imageButton, for: .normal)
            btnLeft.setImage(imageButton, for: .highlighted)
            btnLeft.addTarget(self, action: #selector(popNavigationController), for: .touchUpInside)
            btnLeft.isHidden = false
        }
    }
    
    private func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }

        return statusBarHeight
    }
    
    @objc func popNavigationController() {
        guard let navigation = self.navigation else {
            return
        }

        navigation.popViewController(animated: true)
    }
}
