//
//  WidgetPreviewController.swift
//  Stock-App-Widgets
//
//  Created by Alek Michelson on 6/26/22.
//

import UIKit
import SwiftUI

class WidgetPreviewController: UIViewController {
    private let stackView = UIStackView()
    
    private var topConstraint: NSLayoutConstraint!
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        leadingConstraint = stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        trailingConstraint = view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        
        [topConstraint, leadingConstraint, trailingConstraint]
            .forEach { $0?.isActive = true }
    }
    
    var spacing: CGFloat {
        floor(view.bounds.width * 0.06)
    }
    var widgetHeight: CGFloat {
        (view.bounds.width - 3 * spacing) / 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topConstraint.constant = 25
        leadingConstraint.constant = spacing
        trailingConstraint.constant = spacing
        
        stackView.spacing = spacing
    }
    
    enum Side {
        case left
        case right
    }
    
    
    func addSmallWidget<V: View>(view: V, side: Side) {
        addSmallWidgets(left: view, showLeft: side == .left, right: view, showRight: side == .right)
    }
    
    func addSmallWidgets<V1: View, V2: View>(left: V1, right: V2) {
        addSmallWidgets(left: left, showLeft: true, right: right, showRight: true)
    }
    
    func addSmallWidgets<V1: View, V2: View>(left: V1, showLeft: Bool, right: V2, showRight: Bool) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.heightAnchor.constraint(equalToConstant: widgetHeight).isActive = true
        
        let containerLeft = WidgetContainer(view: left)
        containerLeft.alpha = showLeft ? 1 : 0
        stackView.addArrangedSubview(containerLeft)
        
        let containerRight = WidgetContainer(view: right)
        containerRight.alpha = showRight ? 1 : 0
        stackView.addArrangedSubview(containerRight)
        
        self.stackView.addArrangedSubview(stackView)
    }
    
    func addMediumWidget<V: View>(view: V) {
        let container = WidgetContainer(view: view)
        container.heightAnchor.constraint(equalToConstant: widgetHeight).isActive = true
        stackView.addArrangedSubview(container)
    }
    
    func addLargeWidget<V: View>(view: V) {
        let container = WidgetContainer(view: view)
        container.widthAnchor.constraint(equalTo: container.heightAnchor).isActive = true
        stackView.addArrangedSubview(container)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    class WidgetContainer<V: View>: UIView {
        
        let hostingController: UIHostingController<V>
        
        init(view: V) {
            hostingController = UIHostingController(rootView: view)
            
            super.init(frame: .zero)
            
            translatesAutoresizingMaskIntoConstraints = false
            
            backgroundColor = .white
            layer.cornerRadius = 20
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
            
            addSubview(hostingController.view)
        }
        
        required init?(coder: NSCoder) { fatalError() }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            hostingController.view.frame = bounds
        }
    }
    
    
}
