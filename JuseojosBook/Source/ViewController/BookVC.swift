//
//  BookViewController.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/11/25.
//

import UIKit

import Combine

class BookViewController: UIViewController {
	let bookView = BookView()
	let bookViewModel = BookViewModel()
	var cancellables = Set<AnyCancellable>()

	override func loadView() {
		view = bookView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bookViewModel.bookPublisher?.sink { [weak self] bookInform in
			guard let self else { return }
			self.bookView.titleLabel.text = bookInform.title
		}.store(in: &cancellables)

	}
}

