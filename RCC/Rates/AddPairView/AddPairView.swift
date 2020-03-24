//
//  AddPairView.swift
//  RCC
//
//  Created by Aaron Huánuco on 24/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

final class AddPairView: UIView {
    private var action: (() -> Void)?
    private var leadingConstraint: NSLayoutConstraint?
    var state: State = .empty {
        didSet { changedState(from: oldValue, to: state) }
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    lazy var buttonImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "Plus"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Localizables.button, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localizables.description
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func addAction(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    private func setupView() {
        addSubview(stackView)
        [buttonImage, button, descriptionLabel].forEach(stackView.addArrangedSubview)
        configureConstraints()
    }

    private func configureConstraints() {
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        leadingConstraint = NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: Layout.emptyMargin)
        leadingConstraint?.isActive = true
        
    }
    
    private func changedState(from old: State, to new: State) {
        guard old != new else { return }
        switch state {
        case .empty:
            setupEmpty()
        case .configured:
            setupConfigured()
        }
    }
    
    @objc private func buttonTapped() {
        action?()
    }
    
    private func setupEmpty() {
        stackView.addArrangedSubview(descriptionLabel)
        UIView.animate(withDuration: 0.3) {
            self.stackView.alignment = .center
            self.stackView.axis = .vertical
            self.leadingConstraint?.constant = Layout.emptyMargin
        }
    }
    
    private func setupConfigured() {
        stackView.removeArrangedSubview(descriptionLabel)
        descriptionLabel.removeFromSuperview()
        UIView.animate(withDuration: 0.3, animations: {
            self.stackView.alignment = .leading
            self.stackView.axis = .horizontal
            self.leadingConstraint?.constant = Layout.configuredMargin
        }) { _ in
            self.layoutIfNeeded()
        }
    }
}

extension AddPairView {
    enum State {
        case empty
        case configured
    }
    
    private enum Layout {
        static let addImageSize = CGSize(width: 40, height: 40)
        static let emptyMargin: CGFloat = 56
        static let configuredMargin: CGFloat = 40
    }

    private enum Localizables {
        static let button = "Add currency pair"
        static let description = "Chose a currency to compare their live rates"
    }
}
