//
//  BookViewModel.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/13/25.
//

import Foundation

import Combine

struct BookViewModel {
	let dataServie = DataService()
	private var books: [IndexedBook]?
	var bookPublisher: CurrentValueSubject<IndexedBook, Never>?

	init() {
		dataServie.loadBooks { data in
			switch data {
			case .success(let result):
				self.books = result.enumerated().map(IndexedBook.init)
				guard let firstBook = books?[0]
				else {
					print("error initBook")
					return
				}
				self.bookPublisher = .init(firstBook)
			case .failure(let error):
				print(error)
			}
		}
	}

	func requestData(index: Int) {
		self.bookPublisher?.send(books![index])
	}
}
