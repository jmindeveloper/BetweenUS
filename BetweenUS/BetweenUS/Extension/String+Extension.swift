//
//  String+Extension.swift
//  BetweenUS
//
//  Created by J_Min on 2022/09/03.
//

import UIKit

extension String {
    static func dateToString(date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: date)
    }
}
