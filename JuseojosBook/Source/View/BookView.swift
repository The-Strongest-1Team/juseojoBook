//
//  BookView.swift
//  JuseojosBook
//
//  Created by seongjun cho on 6/13/25.
//

import UIKit

import Then
import SnapKit

class BookView: UIView {
	let titleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		$0.textAlignment = .center
		$0.numberOfLines = 0
	}

	let seriesView = UIView()

	let seriesButton = UIButton(configuration: .filled()).then {
		$0.configuration?.title = "1"
		$0.configuration?.titleAlignment = .center
		$0.configuration?.cornerStyle = .capsule
		$0.configuration?.baseBackgroundColor = .systemBlue
		$0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
	}

	let informView = UIView()

	let bookImageView = UIImageView().then {
		$0.image = UIImage(named: "harrypotter1")
	}

	let informStackView = UIStackView().then {
		$0.axis = .vertical
		$0.distribution = .equalSpacing
	}

	let informTitleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		$0.numberOfLines = 0
	}

	let authorStackview = UIStackView().then {
		$0.axis = .horizontal
		$0.spacing = 8
	}

	let informAuthorTitleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		$0.text = "Author"
		$0.setContentHuggingPriority(.required, for: .horizontal)
	}

	let informAuthorLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
		$0.textColor = .darkGray
	}

	let releasedStackview = UIStackView().then {
		$0.axis = .horizontal
		$0.spacing = 8
	}

	let informRealesedTitleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		$0.text = "Realesed"
		$0.setContentHuggingPriority(.required, for: .horizontal)
	}

	let informRealesedLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		$0.textColor = .gray
	}

	let pagesStackview = UIStackView().then {
		$0.axis = .horizontal
		$0.spacing = 8
	}

	let informPagesTitleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		$0.text = "Pages"
		$0.setContentHuggingPriority(.required, for: .horizontal)
	}

	let informPagesLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		$0.textColor = .gray
	}

	let dedicationStackView = UIStackView().then {
		$0.axis = .vertical
		$0.spacing = 8
	}

	let dedicationTitleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		$0.text = "Dedication"
	}

	let dedicationLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		$0.textColor = .darkGray
		$0.numberOfLines = 0
	}

	let summaryStackView = UIStackView().then {
		$0.axis = .vertical
		$0.spacing = 8
	}

	let summaryTitleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		$0.text = "Summary"
	}

	let summaryLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		$0.textColor = .darkGray
		$0.numberOfLines = 0
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = .white

		addSubview(titleLabel)
		addSubview(seriesView)
		seriesView.addSubview(seriesButton)

		addSubview(informView)
		informView.addSubview(bookImageView)
		informView.addSubview(informStackView)

		informStackView.addArrangedSubview(informTitleLabel)
		informStackView.addArrangedSubview(authorStackview)
		informStackView.addArrangedSubview(releasedStackview)
		informStackView.addArrangedSubview(pagesStackview)

		authorStackview.addArrangedSubview(informAuthorTitleLabel)
		authorStackview.addArrangedSubview(informAuthorLabel)
		releasedStackview.addArrangedSubview(informRealesedTitleLabel)
		releasedStackview.addArrangedSubview(informRealesedLabel)
		pagesStackview.addArrangedSubview(informPagesTitleLabel)
		pagesStackview.addArrangedSubview(informPagesLabel)

		addSubview(dedicationStackView)
		dedicationStackView.addArrangedSubview(dedicationTitleLabel)
		dedicationStackView.addArrangedSubview(dedicationLabel)

		addSubview(summaryStackView)
		summaryStackView.addArrangedSubview(summaryTitleLabel)
		summaryStackView.addArrangedSubview(summaryLabel)

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
			make.leading.trailing.equalToSuperview().inset(20)
		}

		seriesView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(16)
			make.leading.trailing.equalToSuperview().inset(20)
			make.bottom.equalTo(seriesButton.snp.bottom)
		}

		seriesButton.snp.makeConstraints { make in
			make.top.centerX.equalToSuperview()
			make.width.height.equalTo(48)
		}

		informView.snp.makeConstraints { make in
			make.top.equalTo(seriesView.snp.bottom).offset(10)
			make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(5)
			make.bottom.equalTo(bookImageView)
		}

		bookImageView.snp.makeConstraints { make in
			make.top.leading.equalToSuperview()
			make.width.equalTo(100)
			make.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
		}

		informStackView.snp.makeConstraints { make in
			make.top.bottom.trailing.equalToSuperview()
			make.leading.equalTo(bookImageView.snp.trailing).offset(10)
		}

		dedicationStackView.snp.makeConstraints { make in
			make.top.equalTo(informStackView.snp.bottom).offset(24)
			make.leading.trailing.equalToSuperview().inset(20)
		}

		summaryStackView.snp.makeConstraints { make in
			make.top.equalTo(dedicationStackView.snp.bottom).offset(24)
			make.leading.trailing.equalToSuperview().inset(20)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(book: Book) {
		titleLabel.text = book.title
		informTitleLabel.text = book.title
		informAuthorLabel.text = book.author
		informRealesedLabel.text = formatting_strDate(str: book.release_date)
		informPagesLabel.text = "\(book.pages)"
		dedicationLabel.text = book.dedication
		summaryLabel.text = book.summary
	}

	private func formatting_strDate(str: String) -> String {
		let inputFormatter = DateFormatter()
		inputFormatter.dateFormat = "yyyy-MM-dd"

		let outputFormatter = DateFormatter()
		outputFormatter.dateFormat = "MMMM d, yyyy"
		outputFormatter.locale = Locale(identifier: "en_US")

		if let date = inputFormatter.date(from: str) {
			let formattedString = outputFormatter.string(from: date)
			return formattedString
		} else {
			print("Invalid date format")
		}

		return "error"
	}
}

// MARK: - BookViewController Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview {
	BookViewController()
}
#endif
