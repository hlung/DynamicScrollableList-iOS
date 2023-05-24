import UIKit

final class BenefitsView: UIView {

  private var heightWhenEmpty: CGFloat = 0

  private var scaleFactor: CGFloat = 1.0 {
    didSet {
      stackView.spacing = 12 * scaleFactor
      for view in itemViews {
        view.textView.font = .systemFont(ofSize: 16 * scaleFactor)
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
        view.textView.font = .systemFont(ofSize: 16 * scaleFactor)
        stackView.addArrangedSubview(view)
      }

      adjustScaleFactorIfNeeded()
    }
  }

  /**
   steps
   - inputs: bounds.height, scaleFactor
   - when there is a trigger (changing text, view size, trait collection, etc.), run adjustScaleFactorIfNeeded()
   - adjustScaleFactorIfNeeded()
     - checks if stackview height `stackview.sizeToFit(bounds.size).height` exceeds view bounds.height
     - if it doesn't, do nothing
     - if it does, apply smaller font/margins. then again, calculate if it exceeds the height
       - if it doesn't, do nothing
       - if it does, increase intrinsic content size to be the same as stackview size
   - done
   */
  func adjustScaleFactorIfNeeded() {
    print(type(of: self), #function, "start -----")

    // force layout to get correct bounds.height
    setNeedsLayout()
    layoutIfNeeded()
    print("scaleFactor", scaleFactor, stackView.bounds.height, bounds.height)

    if scaleFactor == 1.0 {
      heightWhenEmpty = bounds.height // save for later use
      if stackView.bounds.height > bounds.height {
        scaleFactor = 0.75
      }
    }
    else {
      // Things are a bit tricky when we are in shrinked scaleFactor.
      // We cannot tell whether un-shrinked size will fit by checking if stackView is shorter than bounds.
      // To know this, we need to actually lay out in un-shrinked size,
      // then check if it exceeds the saved "heightWhenEmpty".
      // If it exceeds, we revert scaleFactor back to shrinked one.
      // Otherwise, we keep that unshrinked scaleFactor.
      scaleFactor = 1.0
      stackView.setNeedsLayout()
      stackView.layoutIfNeeded()

      print(
        "trying layout in 1.0 scaleFactor...",
        stackView.bounds.height,
        heightWhenEmpty,
        "exceeding:", stackView.bounds.height > heightWhenEmpty
      )

      if stackView.bounds.height > heightWhenEmpty {
        scaleFactor = 0.75
      }
    }

    setNeedsLayout()
    layoutIfNeeded()
    invalidateIntrinsicContentSize()

    print(type(of: self), #function, "end -----")
  }

  private var overridingIntrinsicContentSize: CGSize? = nil

  override var intrinsicContentSize: CGSize {
    return overridingIntrinsicContentSize ?? stackView.bounds.size
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
//      stackView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor),
//      stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
    ])

    // trigger initial scaleFactor didSet
    scaleFactor = 1.0
  }

}
