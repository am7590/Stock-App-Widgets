//
//  ContentView.swift
//  Stock-App-Widgets
//
//  Created by Alek Michelson on 6/25/22.
//

import SwiftUI

struct ContentView: View {
    
    //let view = StockWidgetEntryView(entry: .init(date: Date(), configuration: .init()))

    var body: some View {

        //StockWidgetEntryView(entry: .init(date: Date(), configuration: .init()))
        WidgetView()
    }
}

struct WidgetView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = WidgetPreviewController
    
    func makeUIViewController(context: Context) -> WidgetPreviewController {
        let vc = WidgetPreviewController()
        vc.addMediumWidget(view: StockWidgetEntryView(entry: .init(date: Date(), configuration: .init())))
        return vc
    }
    
    func updateUIViewController(_ uiViewController: WidgetPreviewController, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
