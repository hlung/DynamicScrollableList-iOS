import UIKit

final class BenefitsView: UIView {

  // MARK: - Properties

  var itemViews: [BenefitItemView] = [] {
    didSet {
      for view in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
      }
      for view in itemViews {
        view.textView.font = .systemFont(ofSize: 16 * scaleFactor)
        stackView.addArrangedSubview(view)
      }

      adjustScaleFactorIfNeeded()
    }
  }

  private var scaleFactor: CGFloat = 1.0 {
    didSet {
      stackView.spacing = 12 * scaleFactor
      for view in itemViews {
        view.textView.font = .systemFont(ofSize: 16 * scaleFactor)
      }
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
    adjustScaleFactorIfNeeded()
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

    // trigger initial scaleFactor didSet
    scaleFactor = 1.0
  }

  /**
   Adjusts `scaleFactor` if needed (on changing itemViews, view size, trait collection, etc.).
   */
  private func adjustScaleFactorIfNeeded() {
    let threshold = heightWhenNoContent()

    // layout stackView in full scale if needed
    if scaleFactor != 1.0 {
      scaleFactor = 1.0
      stackView.setNeedsLayout()
      stackView.layoutIfNeeded()
    }

    // if stackView height is bigger, adjust scaleFactor
    // print(stackView.bounds.height, threshold)
    if stackView.bounds.height > threshold {
      scaleFactor = 0.75
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
