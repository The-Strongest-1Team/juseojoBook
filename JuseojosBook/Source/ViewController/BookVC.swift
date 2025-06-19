//
//  BookViewController.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/11/25.
//

import UIKit

import Combine

class BookViewController: UIViewController, BookViewDelegate {

	let bookView = BookView()
	let bookViewModel = BookViewModel()
	var cancellables = Set<AnyCancellable>()

	override func loadView() {
		bookView.delegate = self
		view = bookView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bookViewModel.bookPublisher?.sink { [weak self] bookInform in
			guard let self else { return }
			self.bookView.configure(book: bookInform)
		}.store(in: &cancellables)
	}

	func didTapButton(_ sender: UIButton) {
		bookViewModel.requestData(index: sender.tag - 1)
	}
}

