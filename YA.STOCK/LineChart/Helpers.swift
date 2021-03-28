//
//  Helpers.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 21.03.2021.
//

import Foundation
import SwiftUI

public struct Styles {
    public static let lineChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        textColor: Color.black,
        legendTextColor: Color.gray)
    
    public static let lineViewDarkMode = ChartStyle(
        backgroundColor: Color.black,
        textColor: Color.white,
        legendTextColor: Color.white)
}

public class ChartStyle {
    public var backgroundColor: Color
    public var textColor: Color
    public var legendTextColor: Color
    public weak var darkModeStyle: ChartStyle?

    public init(backgroundColor: Color, textColor: Color, legendTextColor: Color){
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.legendTextColor = legendTextColor
    }
}

public class ChartData: ObservableObject, Identifiable {
    @Published var points: [(String,Double)]
    var valuesGiven: Bool = false
    var ID = UUID()

    public init<N: BinaryInteger>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        self.valuesGiven = true
    }
    
    public func onlyPoints() -> [Double] {
        return self.points.map{ $0.1 }
    }

    public func onlyDate() -> [String] {
        return self.points.map{ $0.0 }
    }
}

public class TestData{
    static public var values:ChartData = ChartData(
        values: [
            ("2017 Q3",220),
            ("2017 Q4",1550),
            ("2018 Q1",8180),
            ("2018 Q2",18440),
            ("2018 Q3",55840),
            ("2018 Q4",63150),
            ("2019 Q1",50900),
            ("2019 Q2",77550),
            ("2019 Q3",79600),
            ("2019 Q4",92550)
        ]
    )
}
