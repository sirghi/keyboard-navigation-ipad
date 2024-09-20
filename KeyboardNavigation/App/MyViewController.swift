
import UIKit

class MyViewController: UIViewController {
    lazy var pager: UIPageViewController = {
        let pager = FocusablePageViewController(transitionStyle: .scroll, navigationOrientation: .vertical)
        pager.view.backgroundColor = .green
        return pager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        addChild(pager)
        view.addSubview(pager.view)
        pager.didMove(toParent: self)
        pager.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pager.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            pager.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            pager.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pager.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

class PageViewController: UIViewController {
    var page: Pages

    init(with page: Pages) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
        self.focusGroupIdentifier = "page.controller"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let focusableView1 = FocusableView()
        focusableView1.focusGroupIdentifier = "focusable.view"
        focusableView1.backgroundColor = .red
        focusableView1.translatesAutoresizingMaskIntoConstraints = false

        let focusableView2 = FocusableView()
        focusableView2.focusGroupIdentifier = "focusable.view"
        focusableView2.backgroundColor = .green
        focusableView2.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [focusableView1, focusableView2])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            focusableView1.heightAnchor.constraint(equalToConstant: 200),
            focusableView1.widthAnchor.constraint(equalToConstant: 200),
            focusableView2.heightAnchor.constraint(equalToConstant: 200),
            focusableView2.widthAnchor.constraint(equalToConstant: 200),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
