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
    
    private lazy var imageNews: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var imageNewsPaper: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_newYorkTimes")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
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
        
        self.containerView.addSubview(imageNews)
        self.containerView.addSubview(labelTitleNew)
        self.containerView.addSubview(imageNewsPaper)
        self.contentView.addSubview(containerView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            containerView.heightAnchor.constraint(equalToConstant: 100.0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            
            imageNews.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageNews.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageNews.widthAnchor.constraint(equalToConstant: 150.0),
            imageNews.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            labelTitleNew.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10.0),
            labelTitleNew.leadingAnchor.constraint(equalTo: imageNews.trailingAnchor, constant: 10.0),
            labelTitleNew.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),

            imageNewsPaper.topAnchor.constraint(equalTo: labelTitleNew.bottomAnchor),
            imageNewsPaper.heightAnchor.constraint(equalToConstant: 10.0),
            imageNewsPaper.widthAnchor.constraint(equalToConstant: 10.0),
            imageNewsPaper.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10.0),
            imageNewsPaper.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10.0)
        ])
    }
    
    func configure(with data: News) {
        self.imageNews.image = data.image.normalSize
        self.labelTitleNew.text = data.title
    }
}
