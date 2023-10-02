//
//  OTPTextField.swift
//
//  Created by Mohamed Aglan®.
//

import UIKit


class OTPTextField: UITextField, UITextFieldDelegate {
    var didEnterLastDigit: ((String) -> Void)?
    var defaultText = ""
    
    private var isConfigure = false
    private var digitalLabels = [UILabel]()
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(becomeFirstResponder))
        return tap
    }()
    
    func configure(with slotsCount: Int = 4) {
        guard !isConfigure else {return}
        isConfigure.toggle()
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotsCount)
        addSubview(labelsStackView)
        addGestureRecognizer(tapRecognizer)
        NSLayoutConstraint.activate(
            [
                labelsStackView.topAnchor.constraint(equalTo: topAnchor),
                labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                labelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ]
        )
        
    }
    
    private func configureTextField () {
        tintColor = .clear
        textColor = .clear
        keyboardType = .asciiCapableNumberPad
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = . fillEqually
        stackView.spacing = 8
        stackView.semanticContentAttribute = .forceLeftToRight
        
        for _ in 1 ... count {
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 30)
            label.isUserInteractionEnabled = true
            label.text = defaultText
            label.layer.cornerRadius = 10
            label.backgroundColor = .clear
            label.layer.borderWidth = 0.5
            label.layer.borderColor = Theme.colors.borderColor
            label.clipsToBounds = true
            label.textColor = Theme.colors.mainDarkFontColor
            
            stackView.addArrangedSubview(label)
            label.widthAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
            
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0.0, y: label.frame.height - 1, width: label.frame.width, height: 1.0)
            bottomLine.backgroundColor = Theme.colors.borderColor
            label.layer.addSublayer(bottomLine)
            
            digitalLabels.append(label)
        }
        
        return stackView
    }
    @objc private func textDidChange() {
        guard let text = self.text, text.count <= digitalLabels.count else {return}
        for i in 0 ..< digitalLabels.count {
            let currentLabel = digitalLabels[i]
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text = defaultText
            }
        }
        if text.count == digitalLabels.count {
            didEnterLastDigit?(text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else {
            return false
        }
        
        return characterCount < digitalLabels.count || string == ""
    }
    
}
