import UIKit

final class BenefitItemView: UIView {

  lazy var bulletLabel: UILabel = {
    let label = UILabel()
    label.text = "- "
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 16)
    label.adjustsFontSizeToFitWidth = false
    label.textAlignment = .left
    label.textColor = .black
    label.backgroundColor = .systemGreen
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    return label
  }()

  lazy var textView: UITextView = {
    let textView = UITextView()
    textView.text = "Hello world Hello world Hello world"
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.backgroundColor = .init(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1),
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
    addSubview(bulletLabel)
    addSubview(textView)

    NSLayoutConstraint.activate([
      bulletLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      bulletLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      textView.leadingAnchor.constraint(equalTo: bulletLabel.trailingAnchor),
      textView.trailingAnchor.constraint(equalTo: trailingAnchor),
      textView.topAnchor.constraint(equalTo: topAnchor),
      textView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

}
