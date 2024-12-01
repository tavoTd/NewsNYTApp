//
//  NewsListTableViewCell.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 29/11/24.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = self.cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var imageNew: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        imageView.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner],
                               radius: self.cornerRadius)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    private lazy var labelTitleNew: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10.0
        stack.distribution = .fillProportionally
        stack.clipsToBounds = true
        stack.roundCorners(corners: [.layerMaxXMaxYCorner],
                           radius: self.cornerRadius)
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    private lazy var labelPublishedDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var labelSection: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    public static let identifier = "NewsListTableViewCell"
    private let cornerRadius = 12.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildUIComponents()
        self.buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUIComponents() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.lightCyan
        self.contentView.backgroundColor = UIColor.lightCyan
        self.containerView.backgroundColor = UIColor.white
        self.stackView.backgroundColor = UIColor.white
        
        self.stackView.addArrangedSubview(labelPublishedDate)
        self.stackView.addArrangedSubview(labelSection)
        
        self.containerView.addSubview(imageNew)
        self.containerView.addSubview(labelTitleNew)
        self.containerView.addSubview(stackView)
        self.contentView.addSubview(containerView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            containerView.heightAnchor.constraint(equalToConstant: 120.0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            
            imageNew.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageNew.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageNew.widthAnchor.constraint(equalToConstant: 100.0),
            imageNew.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            labelTitleNew.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20.0),
            labelTitleNew.leadingAnchor.constraint(equalTo: imageNew.trailingAnchor, constant: 20.0),
            labelTitleNew.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20.0),
            labelTitleNew.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10.0),
            
            stackView.leadingAnchor.constraint(equalTo: imageNew.trailingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 30.0),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func configure(with data: News) {
        self.imageNew.image = data.image.normal
        self.labelTitleNew.text = data.title
        self.labelSection.text = data.section
        self.labelPublishedDate.text = data.publishedDate
    }
}
