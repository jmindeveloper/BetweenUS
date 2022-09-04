//
//  StackViewSpacer.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/04.
//

import UIKit
import SnapKit

final class StackViewSpacer: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func height(height: CGFloat) -> StackViewSpacer {
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
        return self
    }
    
    func width(width: CGFloat) -> StackViewSpacer {
        self.snp.makeConstraints {
            $0.width.equalTo(width)
        }
        
        return self
    }
}
