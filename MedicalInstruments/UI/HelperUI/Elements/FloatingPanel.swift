//
//  FloatingPanel.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import UIKit
import FloatingPanel

class FloatingLayout: FloatingPanelLayout {
    
    var guide: UILayoutGuide
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelAdaptiveLayoutAnchor(absoluteOffset: 0.5, contentLayout: guide)
        ]
    }
    
    init(guide: UILayoutGuide) {
        self.guide = guide
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        case .full, .half: return 0.5
        default: return 0.0
        }
    }
}
