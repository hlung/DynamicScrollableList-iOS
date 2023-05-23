import UIKit

final class BenefitsView: UIView {

  var scaleFactor: CGFloat = 1.0 {
    didSet {
      stackView.spacing = 12 * scaleFactor
      for view in itemViews {
        view.textView.font = .systemFont(ofSize: 16 * scaleFactor)
      }
      setNeedsLayout()
    }
  }

  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.backgroundColor = .systemGray2
    return scrollView
  }()

  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 12 * scaleFactor
    stackView.distribution = .fill
    stackView.alignment = .center
    stackView.backgroundColor = .systemGray
    return stackView
  }()

  var itemViews: [BenefitItemView] {
    stackView.arrangedSubviews as? [BenefitItemView] ?? []
  }

  override var intrinsicContentSize: CGSize {
    print(type(of: self), stackView.bounds.size)
    return stackView.bounds.size
  }

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
    addSubview(scrollView)
    scrollView.addSubview(stackView)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//      stackView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor),
//      stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
    ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    print(
      type(of: self), #function,
      "intrinsicContentSize:", intrinsicContentSize,
      "bounds.size:", bounds.size
    )

//    print(itemViews.count, stackView.bounds.height)

    // This causes infinite loop
//    for view in itemViews {
//      let size: CGFloat = stackView.bounds.height > 200 ? 12 : 16
//      view.textView.font = .systemFont(ofSize: size)
//    }
  }

  func adjustIfNeeded() {
    
  }

}
