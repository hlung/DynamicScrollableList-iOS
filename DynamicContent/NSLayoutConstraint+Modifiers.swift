import UIKit

public extension NSLayoutConstraint {
  func priority(_ value: UILayoutPriority) -> NSLayoutConstraint {
    self.priority = value
    return self
  }

  func activated() -> NSLayoutConstraint {
    self.isActive = true
    return self
  }
}
