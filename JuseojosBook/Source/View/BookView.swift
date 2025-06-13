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

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = .white

		addSubview(titleLabel)
		addSubview(seriesView)
		seriesView.addSubview(seriesButton)

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
			make.leading.trailing.equalToSuperview().inset(20)
		}

		seriesView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(16)
			make.leading.trailing.equalToSuperview().inset(20)
		}

		seriesButton.snp.makeConstraints { make in
			make.top.centerX.equalToSuperview()
			make.width.height.equalTo(48)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
