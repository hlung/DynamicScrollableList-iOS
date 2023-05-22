import UIKit

class ViewController: UIViewController {

  lazy var addButton: UIButton = {
    let button = UIButton(type: .system, primaryAction: UIAction(title: "Add", handler: { [weak self] _ in
      self?.addBenefit()
    }))
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var removeButton: UIButton = {
    let button = UIButton(type: .system, primaryAction: UIAction(title: "Remove", handler: { [weak self] _ in
      self?.removeBenefit()
    }))
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var cardView: CardView = {
    let view = CardView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(addButton)
    view.addSubview(removeButton)
    view.addSubview(cardView)

    NSLayoutConstraint.activate([
      addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
      addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),

      removeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
      removeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),

      cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
      cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
      cardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      cardView.heightAnchor.constraint(equalToConstant: 400)
    ])

    // items & height
    // 5 145.5
    // 6 177.0
    // 7 208.5

    for _ in 1...5 {
//      let view = BenefitItemView()
//      cardView.benefitsView.stackView.addArrangedSubview(view)

      addBenefit()
    }
  }

  private func addBenefit() {
//      let view = BenefitItemView()
//      self?.cardView.benefitsView.stackView.addArrangedSubview(view)
//      self?.cardView.benefitsView.layoutIfNeeded()
//      self?.cardView.benefitsView.invalidateIntrinsicContentSize()

    if cardView.benefitsView.text?.isEmpty == false {
      cardView.benefitsView.text! += "\n"
    }
    cardView.benefitsView.text! += "Hello world"
  }

  private func removeBenefit() {
//      if let view = self?.cardView.benefitsView.stackView.arrangedSubviews.last {
//        self?.cardView.benefitsView.stackView.removeArrangedSubview(view)
//        view.removeFromSuperview()
//        self?.cardView.benefitsView.layoutIfNeeded()
//        self?.cardView.benefitsView.invalidateIntrinsicContentSize()
//      }

    if let index = cardView.benefitsView.text?.lastIndex(where: { $0 == "\n" }) {
      cardView.benefitsView.text = String(cardView.benefitsView.text!.prefix(upTo: index))
    }
    else {
      cardView.benefitsView.text = ""
    }
  }

//  override func viewDidLayoutSubviews() {
//    print(#function)
//    print(itemViews.count, stackView.bounds.height)
//
//    for view in itemViews {
//      let size: CGFloat = stackView.bounds.height > 200 ? 12 : 16
//      view.textView.font = .systemFont(ofSize: size)
//    }
//  }

}

