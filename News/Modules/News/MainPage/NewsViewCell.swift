//
//  TableViewCell.swift
//  News
//
//  Created by Philip on 08.03.2023.
//

import UIKit
import SDWebImage

final class NewsViewCell: UITableViewCell {
    
    static var cellIdentifier: String {
        String(describing: self)
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 3
        return label
    }()
    
    private var createdDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private var imageNews: UIImageView = {
        let image = UIImageView()
    
        image.contentMode = . scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        createdDateLabel.text = nil
        imageNews.image = nil
    }
    
    func configure(with viewModel: NewsViewModel, at index: Int) {
        titleLabel.text = viewModel.titles[index]
        createdDateLabel.text = viewModel.dates[index]
        if index < viewModel.newsImages.count {
            imageNews.sd_setImage(with: URL(string: viewModel.newsImages[index]), placeholderImage: nil, options: [.progressiveLoad])
        } else {
            imageNews.image = nil
        }
    }
    
    private func setupSubviews() {
        let subviews = [titleLabel, createdDateLabel, imageNews]
        
        subviews.forEach { subview in
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageNews.layoutMarginsGuide.leadingAnchor, constant: -16),
            
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            createdDateLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            imageNews.widthAnchor.constraint(equalToConstant: 85),
            imageNews.heightAnchor.constraint(equalToConstant: 85),
            imageNews.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            imageNews.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            imageNews.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
