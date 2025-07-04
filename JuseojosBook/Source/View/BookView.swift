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

	let seriesStackView = UIStackView().then {
		$0.axis = .horizontal
		$0.spacing = 8
	}

	var seriesButtons = [UIButton]()

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
	}

	private var summaryString = "" {
		willSet(newVal) {
			if newVal.count >= 450 {
				self.summaryButton.isHidden = false
			} else {
				self.summaryButton.isHidden = true
			}
		}
	}

	private var selectedBookIndex = 0
	let summarysKey = "isOpenSummarys"
	weak var delegate: (BookViewDelegate)?
	var openStates: [Bool] {
		get { UserDefaults.standard.array(forKey: summarysKey) as? [Bool] ?? Array(repeating: false, count: 7) }
		set { UserDefaults.standard.set(newValue, forKey: summarysKey) }
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = .white

		// MARK: - set UI component
		setHeaderUI()
		setInformUI()
		setScrollUI()
		makeSeriesButtons()
		setDedicationUI()
		setSummaryUI()
		setChaptersUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// MARK: - Methods
	func configure(book: IndexedBook) {
		// set data
		titleLabel.text = book.title
		informTitleLabel.text = book.title
		informAuthorLabel.text = book.author
		informRealesedLabel.text = DateFormatter.MMMMdyyyy.string(from: book.releaseDate)
		informPagesLabel.text = "\(book.pages)"
		dedicationLabel.text = book.dedication
		selectedBookIndex = book.index
		summaryString = book.summary
		bookImageView.image = UIImage(named: "harrypotter\(selectedBookIndex + 1)")

		// reset chapters
		chapterStackView.arrangedSubviews.dropFirst().forEach { view in
			view.removeFromSuperview()
		}
		// add chapters
		makeChapters(chapters: book.chapters)

		// set button state
		summaryButton.isSelected = openStates[selectedBookIndex]

		// set summaryLabel text
		if !openStates[selectedBookIndex] {
			summaryLabel.text = summaryString.summary(until: 450)
		} else {
			summaryLabel.text = summaryString
		}
	}

	// MARK: - Layout Methods
	private func setScrollUI() {
		addSubview(bookScrollView)

		bookScrollView.snp.makeConstraints { make in
			make.top.equalTo(seriesStackView.snp.bottom).offset(24)
			make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
		}
	}

	private func setChaptersUI() {
		bookScrollView.addSubview(chapterStackView)
		chapterStackView.addArrangedSubview(chapterTitleLabel)

		chapterStackView.snp.makeConstraints { make in
			make.top.equalTo(summaryButton.snp.bottom).offset(12)
			make.leading.trailing.equalTo(bookScrollView.frameLayoutGuide).inset(20)
			make.bottom.equalToSuperview().inset(24)
		}
	}

	private func setSummaryUI() {
		bookScrollView.addSubview(summaryStackView)
		summaryStackView.addArrangedSubview(summaryTitleLabel)
		summaryStackView.addArrangedSubview(summaryLabel)
		bookScrollView.addSubview(summaryButton)

		// Setting summrays UserDefaults and isSelected
		if UserDefaults.standard.array(forKey: summarysKey) == nil {
			UserDefaults.standard.set(Array(repeating: false, count: 7), forKey: summarysKey)
		}
		if openStates[selectedBookIndex] {
			summaryButton.isSelected = true
		} else {
			summaryButton.isSelected = false
		}

		summaryButton.addTarget(self, action: #selector(tapSummaryButton), for: .touchUpInside)

		summaryStackView.snp.makeConstraints { make in
			make.top.equalTo(dedicationStackView.snp.bottom).offset(24)
			make.leading.trailing.equalTo(bookScrollView.frameLayoutGuide).inset(20)
		}

		summaryButton.snp.makeConstraints { make in
			make.top.equalTo(summaryStackView.snp.bottom).offset(8)
			make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
		}
	}

	private func setDedicationUI() {
		bookScrollView.addSubview(dedicationStackView)
		dedicationStackView.addArrangedSubview(dedicationTitleLabel)
		dedicationStackView.addArrangedSubview(dedicationLabel)

		dedicationStackView.snp.makeConstraints { make in
			make.top.equalTo(informStackView.snp.bottom).offset(24)
			make.leading.trailing.equalTo(bookScrollView.frameLayoutGuide).inset(20)
		}
	}

	private func setInformUI() {
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

		informView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.trailing.equalTo(bookScrollView.frameLayoutGuide).inset(20)
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
	}

	private func setHeaderUI() {
		addSubview(titleLabel)
		addSubview(seriesStackView)

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
			make.leading.trailing.equalToSuperview().inset(20)
		}

		seriesStackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(16)
			make.width.equalTo(UIScreen.main.bounds.width - 40)
			make.centerX.equalToSuperview()
		}
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

	private func makeSeriesButtons() {
		for i in 1...7 {
			let seriesButton = UIButton(configuration: .filled()).then {
				$0.tag = i
				$0.configurationUpdateHandler = { button in
					var config = button.configuration ?? .filled()
					config.title = "\(button.tag)"
					config.titleAlignment = .center
					config.cornerStyle = .capsule

					switch button.state {
					case .selected:
						config.baseBackgroundColor = .systemBlue
						config.baseForegroundColor = .systemGray5
					default:
						config.baseBackgroundColor = .systemGray5
						config.baseForegroundColor = .systemBlue
					}
					button.configuration = config
				}

				if i == 1 {
					$0.isSelected = true
				}
			}

			seriesButtons.append(seriesButton)
			seriesStackView.addArrangedSubview(seriesButton)
			seriesButton.snp.makeConstraints { make in
				make.height.equalTo(seriesButton.snp.width)
			}

			seriesButton.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
		}
	}

	// MARK: - Button event method
	@objc func tapSummaryButton(_ sender: UIButton) {
		if openStates[selectedBookIndex] {
			openStates[selectedBookIndex] = false
		} else {
			openStates[selectedBookIndex] = true
		}

		if !openStates[selectedBookIndex] {
			summaryLabel.text = summaryString.summary(until: 450)
		} else {
			summaryLabel.text = summaryString
		}

		sender.isSelected.toggle()
	}

	@objc func seriesButtonTapped(_ sender: UIButton) {
		guard !sender.isSelected else { return }
		for button in seriesButtons {
			button.isSelected = (button == sender)
		}
		delegate?.didTapButton(sender)
		print("tap \(sender.tag)")
	}
}
// MARK: - delegate
protocol BookViewDelegate: AnyObject {
	func didTapButton(_ sender: UIButton)
}

// MARK: - BookViewController Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview {
	BookViewController()
}
#endif
