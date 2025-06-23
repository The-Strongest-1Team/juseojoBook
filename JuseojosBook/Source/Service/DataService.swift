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
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
			let bookResponse = try decoder.decode(BookResponse.self, from: data)
			completion(.success(bookResponse.data))
		} catch {
			print("🚨 JSON 파싱 에러 : \(error)")
			completion(.failure(DataError.parsingFailed))
		}
	}
}
