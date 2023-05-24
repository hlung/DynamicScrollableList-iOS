import UIKit

final class CardView: UIView {

  lazy var headerView: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.text = "Header"
    view.textAlignment = .center
    view.backgroundColor = .systemTeal
    return view
  }()

  lazy var benefitsView: BenefitsView = {
    let view = BenefitsView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

//  lazy var benefitsView: UITextView = {
//    let view = UITextView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()

//  lazy var benefitsView: UILabel = {
//    let view = UILabel()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.text = ""
//    view.numberOfLines = 0
//    view.adjustsFontSizeToFitWidth = true
//    view.minimumScaleFactor = 0.75
//    return view
//  }()

  lazy var footerView: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.text = "Footer"
    view.textAlignment = .center
    view.backgroundColor = .systemTeal
    return view
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
    addSubview(headerView)
    addSubview(benefitsView)
    addSubview(footerView)

    // We shrink headerView first, then footerView, and benefitsView.
    // So we need to set priorities for these views in that order, from lowest to highest.

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: topAnchor),
      headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 100).priority(.init(700)),
      headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

      footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      footerView.heightAnchor.constraint(equalToConstant: 100).priority(.init(800)),
      footerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

      benefitsView.leadingAnchor.constraint(equalTo: leadingAnchor),
      benefitsView.trailingAnchor.constraint(equalTo: trailingAnchor),
      benefitsView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      benefitsView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
    ])

    benefitsView.setContentCompressionResistancePriority(.init(900), for: .vertical)
  }

  func addBenefit() {
    let view = BenefitItemView()
    view.translatesAutoresizingMaskIntoConstraints = false
    benefitsView.itemViews = benefitsView.itemViews + [view]

//    benefitsView.stackView.addArrangedSubview(view)
//    benefitsView.layoutIfNeeded() // make stack view have correct size, so we can calculate intrinsicContentSize later
//    benefitsView.invalidateIntrinsicContentSize()

//    if cardView.benefitsView.text?.isEmpty == false {
//      cardView.benefitsView.text! += "\n"
//    }
//    cardView.benefitsView.text! += "Hello world"
  }

  func removeBenefit() {
    if !benefitsView.itemViews.isEmpty {
      benefitsView.itemViews.removeLast()
    }

//    if let view = benefitsView.stackView.arrangedSubviews.last {
//      benefitsView.stackView.removeArrangedSubview(view)
//      view.removeFromSuperview()
//      benefitsView.layoutIfNeeded()
//      benefitsView.invalidateIntrinsicContentSize()
//    }

//    if let index = cardView.benefitsView.text?.lastIndex(where: { $0 == "\n" }) {
//      cardView.benefitsView.text = String(cardView.benefitsView.text!.prefix(upTo: index))
//    }
//    else {
//      cardView.benefitsView.text = ""
//    }
  }

}
