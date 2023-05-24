import UIKit

final class BenefitsView: UIView {

  // MARK: - Properties

  private let regularConfig = Config(fontSize: 16, itemSpacing: 12)
  private let compactConfig = Config(fontSize: 12, itemSpacing: 8)

  private var currentConfig: Config {
    didSet {
      stackView.spacing = currentConfig.itemSpacing
      for view in itemViews {
        view.textView.font = .systemFont(ofSize: currentConfig.fontSize)
      }
    }
  }

  var itemViews: [BenefitItemView] = [] {
    didSet {
      for view in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
      }
      for view in itemViews {
        view.textView.font = .systemFont(ofSize: currentConfig.fontSize)
        stackView.addArrangedSubview(view)
      }
      updateCurrentConfigIfNeeded()
    }
  }

  private var overridingIntrinsicContentSize: CGSize? = nil

  // MARK: - Views

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
    stackView.distribution = .fill
    stackView.alignment = .center
    stackView.backgroundColor = .systemGray
    return stackView
  }()

  // MARK: - Inits

  init() {
    currentConfig = regularConfig
    super.init(frame: .zero)
    setupViews()
  }

  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  override var intrinsicContentSize: CGSize {
    return overridingIntrinsicContentSize ?? stackView.bounds.size
  }

  override func layoutSubviews() {
    super.layoutSubviews()
//    print(type(of: self), #function)
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    updateCurrentConfigIfNeeded()
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
    ])

    // trigger currentConfig didSet
    currentConfig = regularConfig
  }

  /**
   Updates `currentConfig` if needed (on changing itemViews, view size, trait collection, etc.).
   */
  private func updateCurrentConfigIfNeeded() {
    let threshold = heightWhenNoContent()

    // layout stackView in full scale if needed
    if currentConfig != regularConfig {
      currentConfig = regularConfig
      stackView.setNeedsLayout()
      stackView.layoutIfNeeded()
    }

    // if stackView height is bigger, update currentConfig
    // print(stackView.bounds.height, threshold)
    if stackView.bounds.height > threshold {
      currentConfig = compactConfig
      stackView.setNeedsLayout()
      stackView.layoutIfNeeded()
    }

    // communicate intrinsicContentSize change after stackView adjustment
    invalidateIntrinsicContentSize()
  }

  private func heightWhenNoContent() -> CGFloat {
    overridingIntrinsicContentSize = .zero
    invalidateIntrinsicContentSize()
    superview?.setNeedsLayout()
    superview?.layoutIfNeeded()

    let minimumHeight = bounds.height
//    print("minimumHeight:", minimumHeight)

    overridingIntrinsicContentSize = nil
    invalidateIntrinsicContentSize()
    superview?.setNeedsLayout()
    superview?.layoutIfNeeded()

    return minimumHeight
  }

}

extension BenefitsView {

  private struct Config: Equatable {
    let fontSize: CGFloat
    let itemSpacing: CGFloat
  }

}
