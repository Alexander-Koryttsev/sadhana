//
//  Button.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 7/17/17.
//  Copyright © 2017 Alexander Koryttsev. All rights reserved.
//



class Button: UIButton {
    dynamic override var isEnabled: Bool { get {
            return super.isEnabled
        } set {
            super.isEnabled = newValue
            self.updateBackgroundColor()
        }
    }

    dynamic override var isHighlighted: Bool { get {
        return super.isHighlighted
        } set {
            super.isHighlighted = newValue
            self.updateBackgroundColor()
        }
    }

    init() {
        super.init(frame:CGRect())
        updateBackgroundColor()
    }

    func updateBackgroundColor() {
        if state.contains(.disabled) {
            backgroundColor = .sdSilver
        }
        else if state.contains(.highlighted) {
            backgroundColor = .sdButterscotch
        }
        else {
            backgroundColor = .sdTangerine
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
