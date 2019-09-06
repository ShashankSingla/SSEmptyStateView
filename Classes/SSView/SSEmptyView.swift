//
//  SSEmptyView.swift
//  Pods-SSEmptyView_Example
//
//  Created by shashank on 06/09/19.
//

import Foundation
import UIKit


protocol EmptyViewDelegate: class {
    func viewDidRefreshTapped()
}

public class SSEmptyView: UIView {
    public var imageName: String? {
        didSet {
            if let imageName = imageName, let image = UIImage(named: imageName) {
                imageView.isHidden = false
                imageView.image = image
            } else {
                imageView.isHidden = true
            }
        }
    }
    
    public var refreshImage: UIImage? = UIImage(named: "refresh") {
        didSet {
            refreshBtn.setImage(refreshImage, for: .normal)
        }
    }
    
    public var refreshTitle: String = "Refresh" {
        didSet {
            refreshBtn.setTitle(refreshTitle, for: .normal)
        }
    }
    
    public var refreshTitleFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            refreshBtn.titleLabel?.font = refreshTitleFont
        }
    }
    
    public var showRefreshButton: Bool = false {
        didSet {
            refreshBtn.isHidden = !showRefreshButton
        }
    }
    
    public var titleText: String? {
        didSet {
            titleLable.text = titleText ?? ""
        }
    }
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            titleLable.font = titleFont
        }
    }
    
    public var titleColor: UIColor = .black {
        didSet {
            titleLable.textColor = titleColor
        }
    }
    
    public var subTitleFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            subLable.font = subTitleFont
        }
    }
    
    public var subTitleColor: UIColor = .black {
        didSet {
            subLable.textColor = subTitleColor
        }
    }
    
    public var subText: String? {
        didSet {
            subLable.text = subText ?? ""
        }
    }
    
    private lazy var refreshBtn: UIButton = {
        var refreshBtn: UIButton = UIButton()
        refreshBtn.isHidden = !showRefreshButton
        refreshBtn.tintColor = .black
        refreshBtn.setImage(refreshImage, for: .normal)
        refreshBtn.titleLabel?.font = refreshTitleFont
        refreshBtn.setTitle(refreshTitle, for: .normal)
        refreshBtn.setTitleColor(.black, for: .normal)
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.imageView?.contentMode = .scaleAspectFit
        refreshBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: -2, bottom: 5, right: 0)
        refreshBtn.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        return refreshBtn
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if let imageName = imageName, let image = UIImage(named: imageName) {
            imageView.image = image
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        return imageView
    }()
    
    private lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.numberOfLines = 0
        titleLable.text = titleText ?? ""
        titleLable.textAlignment = .center
        return titleLable
    }()
    
    private lazy var subLable: UILabel = {
        let subLable = UILabel()
        subLable.translatesAutoresizingMaskIntoConstraints = false
        subLable.numberOfLines = 0
        subLable.textAlignment = .center
        subLable.text = subText ?? ""
        return subLable
        
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLable)
        stackView.addArrangedSubview(subLable)
        stackView.addArrangedSubview(refreshBtn)
        return stackView
    }()
    
    
    weak var delegate: EmptyViewDelegate?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    convenience public init(frame: CGRect, image: String?, titleText: String?, subText: String?) {
        self.init(frame: frame)
        self.imageName = image
        self.titleText = titleText
        self.subText = subText
        setupView()
        
    }
    
    @objc private func refreshTapped() {
        delegate?.viewDidRefreshTapped()
    }
    
    private func setupView() {
        setImageConstaints()
        setStackViewConstraints()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setStackViewConstraints()
    }
    
    override public func updateConstraints() {
        super.updateConstraints()
        setStackViewConstraints()
    }
    
    private func setImageConstaints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 95).isActive = true
    }
    
    private func setStackViewConstraints() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}
