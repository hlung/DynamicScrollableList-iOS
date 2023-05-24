import UIKit

class ViewController: UIViewController {

  lazy var addButton: UIButton = {
    let button = UIButton(type: .system, primaryAction: UIAction(title: "Add", handler: { [weak self] _ in
      self?.cardView.addBenefit()
    }))
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var removeButton: UIButton = {
    let button = UIButton(type: .system, primaryAction: UIAction(title: "Remove", handler: { [weak self] _ in
      self?.cardView.removeBenefit()
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
      cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
    ])

//    cardView.addBenefit()

    for _ in 1...3 {
      cardView.addBenefit()
    }
  }

}

