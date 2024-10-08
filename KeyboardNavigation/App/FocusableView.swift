import UIKit

class FocusableView: UIView {
    override var canBecomeFocused: Bool { true }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemFill
        self.focusEffect = UIFocusHaloEffect()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
