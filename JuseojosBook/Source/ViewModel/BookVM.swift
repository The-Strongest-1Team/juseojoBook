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
	var books: [Book]?
	var bookPublisher: CurrentValueSubject<Book, Never>?

	init() {
		dataServie.loadBooks { data in
			switch data {
			case .success(let book):
				self.bookPublisher = .init(book[0])
				self.books = book
			case .failure(let error):
				print(error)
			}
		}
	}

	func requestData(index: Int) {
		self.bookPublisher?.send(books![index])
	}
}
