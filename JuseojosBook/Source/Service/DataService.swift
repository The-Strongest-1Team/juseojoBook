//
//  DataService.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/12/25.
//

import Foundation

class DataService {
	enum DataError: Error {
		case fileNotFound
		case parsingFailed
	}

	func loadBooks(completion: (Result<[Book], Error>) -> Void) {
		guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
			completion(.failure(DataError.fileNotFound))
			return
		}

		do {
			let data = try Data(contentsOf: URL(fileURLWithPath: path))
			let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
			let books = bookResponse.data.map { $0.attributes }
			completion(.success(books))
		} catch {
			print("🚨 JSON 파싱 에러 : \(error)")
			completion(.failure(DataError.parsingFailed))
		}
	}
}
