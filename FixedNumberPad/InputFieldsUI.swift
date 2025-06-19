import SwiftUI
import UIKit

struct KeyPadInput: UIViewRepresentable {
    @Binding var text: String
    var isStyled: Bool
    var label: String
    var unit: String

    func makeUIView(context: Context) -> UIView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10


        let labelView = UILabel()
        labelView.text = label
        labelView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        labelView.font = UIFont.preferredFont(forTextStyle: .title2)
        labelView.textAlignment = .left
        
        let textField = UITextField()
        textField.tag = 99
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.inputView = UIView() // disables keyboard
       textField.textAlignment = .left
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = isStyled ? 3 : 1
        textField.layer.borderColor = (isStyled ? UIColor.red : UIColor.gray).cgColor
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 84).isActive = true
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 11
        
        let unitLabel = UILabel()
        unitLabel.text = unit
        unitLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        unitLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
        unitLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        
        stack.addArrangedSubview(labelView)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(unitLabel)

        return stack
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let stack = uiView as? UIStackView,
              let textField = stack.arrangedSubviews.first(where: { $0.tag == 99 }) as? UITextField
        else { return }

        textField.text = text
        textField.layer.borderWidth = isStyled ? 3 : 1
        textField.layer.borderColor = (isStyled ? UIColor.red : UIColor.gray).cgColor
    }
}
