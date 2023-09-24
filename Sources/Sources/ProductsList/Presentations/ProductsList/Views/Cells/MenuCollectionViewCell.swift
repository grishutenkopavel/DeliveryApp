//
//  MenuCollectionViewCell.swift
//  
//
//  Created by Павел Гришутенко on 23.09.2023.
//

import UIKit
import UIComponents


final class MenuCollectionViewCell: UICollectionViewCell {
    
    let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptionContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .accentGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: MenuCellModel) {
        titleLabel.text = model.name
        countLabel.text = String.pluralString(format: .foodCount, model.count ?? 0)
        descriptionContainer.backgroundColor = model.isSelected ? .accentViolet : .accentGray
        foodImageView.image = model.image
    }
    
    private func prepareView() {
        layer.cornerRadius = 12
        clipsToBounds = true
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(countLabel)
        addSubviews(foodImageView, descriptionContainer, textStackView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
            descriptionContainer.topAnchor.constraint(equalTo: centerYAnchor),
            descriptionContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textStackView.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 5),
            textStackView.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 5),
            textStackView.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -5),
            textStackView.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -5),
            
            foodImageView.topAnchor.constraint(equalTo: topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodImageView.bottomAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}


