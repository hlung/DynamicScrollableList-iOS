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

//  lazy var benefitsView: BenefitsView = {
//    let view = BenefitsView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()

//  lazy var benefitsView: UITextView = {
//    let view = UITextView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()

  lazy var benefitsView: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.text = ""
    view.numberOfLines = 0
    view.adjustsFontSizeToFitWidth = true
    view.minimumScaleFactor = 0.75
    return view
  }()

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

    benefitsView.setContentCompressionResistancePriority(.init(900), for: .vertical)

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: topAnchor),
      headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 100).priority(.init(800)),
      headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

      footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      // footer is shrinked first, so it has lower priority
      footerView.heightAnchor.constraint(equalToConstant: 100).priority(.init(700)),
      footerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

      benefitsView.leadingAnchor.constraint(equalTo: leadingAnchor),
      benefitsView.trailingAnchor.constraint(equalTo: trailingAnchor),
      benefitsView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      benefitsView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
    ])
  }

  override func layoutSubviews() {
    super.layoutSubviews()
//    print(type(of: self), #function)
  }

}
