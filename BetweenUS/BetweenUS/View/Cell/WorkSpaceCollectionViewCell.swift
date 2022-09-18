//
//  WorkSpaceCollectionViewCell.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/18.
//

import UIKit
import SnapKit

final class WorkSpaceCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WorkSpaceCollectionViewCell"
    
    // MARK: - Properties
    private let workSpaceNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        configureSubViews()
        setConstraintsOfWorkSpaceNameLabel()
        configureCellShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.bounds.height / 2
    }
    
    // MARK: - Method
    func configureCell(workSpace: WorkSpace) {
        workSpaceNameLabel.text = workSpace.name
    }
    
    // MARK: - UI
    private func configureSubViews() {
        [workSpaceNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setConstraintsOfWorkSpaceNameLabel() {
        workSpaceNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func configureCellShadow() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
