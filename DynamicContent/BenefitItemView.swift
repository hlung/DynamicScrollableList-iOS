import UIKit

final class VikiPassTrackBenefitItemView: UIView {

  lazy var textView: UITextView = {
    let textView = UITextView()
    textView.text = "Hello world"
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.backgroundColor = .init(
      red: CGFloat.random(in: 0...1),
      green: CGFloat.random(in: 0...1),
      blue: CGFloat.random(in: 0...1),
      alpha: 1
    )
    textView.textAlignment = .left
    textView.textColor = .black
    textView.isScrollEnabled = false
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 0
    textView.isEditable = false
    textView.setContentCompressionResistancePriority(.required, for: .vertical)
    return textView
  }()

  // MARK: - Inits

  init() {
    super.init(frame: .zero)
    setupViews()
  }

  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
  }

  // MARK: - Methods

  private func setupViews() {
    addSubview(textView)
    self.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textView.leadingAnchor.constraint(equalTo: leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: trailingAnchor),
      textView.topAnchor.constraint(equalTo: topAnchor),
      textView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

}
