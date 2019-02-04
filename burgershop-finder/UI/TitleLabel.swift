//
//  TitleLabel.swift
//  burgershop-finder
//
//  Created by e.vanags on 05/12/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

final class TitleLabel: SetupLabel {

    override var text: String? {
        get {
            return attributedText?.string
        }
        set {
            setAttributedText(text)
        }
    }

    override func setup() {
        let fontSize = font.pointSize
        font = .withSize(fontSize)
    }

    public func setTitle(_ text: String? = "Title") {
        self.text = text
    }

    private func setAttributedText(_ string: String?) {
        attributedText = NSAttributedString(string)
    }
}
