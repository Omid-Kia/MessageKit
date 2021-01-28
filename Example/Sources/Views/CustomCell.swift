/*
 MIT License
 
 Copyright (c) 2017-2019 MessageKit
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit
import MessageKit

open class CustomCell: MessageContentCell {
    
    var messageLabel = MessageLabel()
    lazy var customView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customView.heightAnchor.constraint(equalToConstant: 40),
            customView.widthAnchor.constraint(equalToConstant: 40)
        ])
        contentView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 40),
            messageLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        layoutIfNeeded()
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.italicSystemFont(ofSize: 13)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        messageLabel.frame = contentView.bounds

    }
    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? MessagesCollectionViewLayoutAttributes {
            messageLabel.textInsets = attributes.messageLabelInsets
//            messageLabel.messageLabelFont = attributes.messageLabelFont
            messageLabel.frame = messageContainerView.bounds
        }
    }
//    open override func layoutCellTopLabel(with attributes: MessagesCollectionViewLayoutAttributes) {
//        super.layoutMessageTopLabel(with: )
//    }
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)

        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            return
//            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }

        let enabledDetectors = displayDelegate.enabledDetectors(for: message, at: indexPath, in: messagesCollectionView)

        messageLabel.configure {
            messageLabel.enabledDetectors = enabledDetectors
            for detector in enabledDetectors {
                let attributes = displayDelegate.detectorAttributes(for: detector, and: message, at: indexPath)
                messageLabel.setAttributes(attributes, detector: detector)
            }
//            let textMessageKind =
//            switch textMessageKind {
//            case .text(let text), .emoji(let text):
//                let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
//                messageLabel.text = text
//                messageLabel.textColor = textColor
//                if let font = messageLabel.messageLabelFont {
//                    messageLabel.font = font
//                }
//            case .attributedText(let text):
//                messageLabel.attributedText = text
//            default:
//                break
//            }
        }
    }
    
}
