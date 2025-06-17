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

	let bookScrollView = UIScrollView().then {
		$0.showsVerticalScrollIndicator = false
	}

	let chapterStackView = UIStackView().then {
		$0.axis = .vertical
		$0.spacing = 8
	}

	let chapterTitleLabel = UILabel().then {
		$0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
		$0.text = "Chapters"
	}

	let summaryButton = UIButton().then {
		$0.setTitle("더 보기", for: .normal)
		$0.setTitle("접기", for: .selected)
		$0.setTitleColor(.systemBlue, for: .normal)
		$0.isHidden = true
		if UserDefaults.standard.bool(forKey: "isOpenSummary") {
			$0.isSelected = true
		} else {
			$0.isSelected = false
		}
	}

	var summaryString = "" {
		willSet(newVal) {
			DispatchQueue.main.async {
				if newVal.count >= 450 {
					self.summaryButton.isHidden = false
				} else {
					self.summaryButton.isHidden = true
				}
			}
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = .white
		summaryButton.addTarget(self, action: #selector(tapSummaryButton), for: .touchUpInside)
		
		addSubview(titleLabel)
		addSubview(seriesView)
		seriesView.addSubview(seriesButton)

		addSubview(bookScrollView)

		bookScrollView.addSubview(informView)
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

		bookScrollView.addSubview(dedicationStackView)
		dedicationStackView.addArrangedSubview(dedicationTitleLabel)
		dedicationStackView.addArrangedSubview(dedicationLabel)

		bookScrollView.addSubview(summaryStackView)
		summaryStackView.addArrangedSubview(summaryTitleLabel)
		summaryStackView.addArrangedSubview(summaryLabel)

		bookScrollView.addSubview(chapterStackView)
		chapterStackView.addArrangedSubview(chapterTitleLabel)

		addSubview(summaryButton)

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

		bookScrollView.snp.makeConstraints { make in
			make.top.equalTo(seriesView.snp.bottom).offset(10)
			make.leading.trailing.bottom.equalToSuperview()
		}

		informView.snp.makeConstraints { make in
			make.top.equalToSuperview()
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
			make.leading.trailing.equalTo(self).inset(20)
		}

		summaryStackView.snp.makeConstraints { make in
			make.top.equalTo(dedicationStackView.snp.bottom).offset(24)
			make.leading.trailing.equalTo(self).inset(20)
		}

		chapterStackView.snp.makeConstraints { make in
			make.top.equalTo(summaryStackView.snp.bottom).offset(24)
			make.leading.trailing.equalTo(self).inset(20)
			make.bottom.equalToSuperview().inset(24)
		}

		summaryButton.snp.makeConstraints { make in
			make.top.equalTo(summaryStackView.snp.bottom).offset(8)
			make.trailing.equalToSuperview().inset(20)
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
		summaryString = book.summary
		setSummaryStr()
		makeChapters(chapters: book.chapters)
	}

	private func makeChapters(chapters: [Chapter]) {
		for chapter in chapters {
			let chapterLabel = UILabel().then {
				$0.font = .systemFont(ofSize: 14, weight: .medium)
				$0.textColor = .darkGray
				$0.text = chapter.title
				$0.numberOfLines = 0
			}

			chapterStackView.addArrangedSubview(chapterLabel)
		}
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

	private func setSummaryStr() {
		if UserDefaults.standard.bool(forKey: "isOpenSummary") == false {
			summaryLabel.text = String(summaryString.prefix(450)) + "..."
		} else {
			summaryLabel.text = summaryString
		}
	}

	@objc func tapSummaryButton(_ sender: UIButton) {
		let isOpenSummary = UserDefaults.standard.bool(forKey: "isOpenSummary")

		if isOpenSummary {
			UserDefaults.standard.set(false, forKey: "isOpenSummary")
		} else {
			UserDefaults.standard.set(true, forKey: "isOpenSummary")
		}
		setSummaryStr()
		sender.isSelected.toggle()
	}
}

// MARK: - BookViewController Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview {
	BookViewController()
}
#endif
