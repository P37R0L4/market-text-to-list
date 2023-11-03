//
//  CameraScannerViewController.swift
//  MarketTextToList
//
//  Created by Lucas Petrola on 13/10/23.
//
import SwiftUI
import UIKit
import VisionKit

struct CameraScannerViewController: UIViewControllerRepresentable {
    @Binding var startScanning: Bool
    @Binding var showCameraScannerView: Bool
    @Binding var scanResult: String
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        
        let viewController =  DataScannerViewController(recognizedDataTypes: [.text()],qualityLevel: .fast,recognizesMultipleItems: false, isHighFrameRateTrackingEnabled: false, isHighlightingEnabled: true)
        
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ viewController: DataScannerViewController, context: Context) {
        guard startScanning else {
            viewController.stopScanning()
            return
        }
        
        try? viewController.startScanning()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: CameraScannerViewController
        
        init(_ parent: CameraScannerViewController) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                parent.scanResult = text.transcript
                parent.showCameraScannerView = false
            default:
                break
            }
        }
    }
}

#Preview {
    CameraScannerViewController(
        startScanning: .constant(true),
        showCameraScannerView: .constant(false),
        scanResult: .constant("")
    )
}
