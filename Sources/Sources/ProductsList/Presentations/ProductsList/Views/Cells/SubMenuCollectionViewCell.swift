//
//  SubMenuCollectionViewCell.swift
//  
//
//  Created by Павел Гришутенко on 23.09.2023.
//

import UIKit
import UIComponents


final class SubMenuCollectionViewCell: UICollectionViewCell {
    
    let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let compositionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentLayoutGuide = UILayoutGuide()
    
    private let descriptionContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let spicyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "spicy", in: Bundle.module, compatibleWith: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return imageView
    }()
    
    private let inCartButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.cornerStyle = .large
        configuration.baseBackgroundColor = .accentViolet
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(ProductsListStrings.inCart, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: SubMenuCellModel) {
        title.text = model.name
        compositionLabel.text = model.composition
        
        let resultString = NSMutableAttributedString()
       
        let priceStringAttributeds: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
        ]
        let priceString = NSAttributedString(
            string: (model.price?.replacingOccurrences(of: ".00", with: "") ?? "-") + " ₽",
            attributes: priceStringAttributeds
        )
        let weightStringAttributeds: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray,
        ]
        let weightString = NSAttributedString(string: " / " + (model.weight ?? "-"), attributes: weightStringAttributeds)

        resultString.append(priceString)
        resultString.append(weightString)
        priceLabel.attributedText = resultString
        foodImageView.image = model.image
        spicyImageView.isHidden = !(model.isSpacy ?? false)
    }
    
    private func prepareView() {
        layer.cornerRadius = 12
        clipsToBounds = true
        addLayoutGuide(contentLayoutGuide)
        textStackView.addArrangedSubview(title)
        textStackView.addArrangedSubview(compositionLabel)
        descriptionContainer.addSubviews(textStackView, priceLabel, spicyImageView)
        addSubviews(descriptionContainer, foodImageView, inCartButton)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 5),
            textStackView.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 5),
            textStackView.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -5),
            textStackView.bottomAnchor.constraint(lessThanOrEqualTo: priceLabel.topAnchor, constant: -5),
                                                  
            priceLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -5),
            priceLabel.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -5),
            
            contentLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentLayoutGuide.bottomAnchor.constraint(equalTo: inCartButton.centerYAnchor),
            
            descriptionContainer.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            descriptionContainer.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            descriptionContainer.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            descriptionContainer.bottomAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
            
            foodImageView.topAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            foodImageView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            
            inCartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            inCartButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            inCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            spicyImageView.widthAnchor.constraint(equalTo: contentLayoutGuide.widthAnchor, multiplier: 0.10),
            spicyImageView.heightAnchor.constraint(equalTo: contentLayoutGuide.heightAnchor, multiplier: 0.10),
            spicyImageView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -5),
            spicyImageView.bottomAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor, constant: -5)
        ])
    }
}

