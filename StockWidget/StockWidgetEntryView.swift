//
//  StockWidgetEntryView.swift
//  Stock-App-Widgets
//
//  Created by Alek Michelson on 6/25/22.
//

import WidgetKit
import SwiftUI

struct StockWidgetEntryView : View {
    var entry: SimpleEntry

    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            Text(entry.date, style: .time)
        }
       
        
    }
}
