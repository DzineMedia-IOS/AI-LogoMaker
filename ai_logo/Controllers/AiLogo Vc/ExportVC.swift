//
//  ExportVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit
import SDWebImage
import MobileCoreServices

class ExportVC: UIViewController {
    
    @IBOutlet weak var quality: UISegmentedControl!
    @IBOutlet weak var format: UISegmentedControl!
    @IBOutlet weak var exportView: UIView!
    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var btnPro: UIButton!
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var lblPrompt: UILabel!
    
    var imgUrl: String?
    let imgArr = ["mock_1","mock_2", "mock_3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProjectCell", bundle: nil)
        collectionVIew.register(nib, forCellWithReuseIdentifier: "ProjectCell")
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        
        
        if let imgUrl = imgUrl, let url = URL(string: imgUrl) {
            // Load the image using SDWebImage
            previewImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
        } else {
            //            previewImg.image = UIImage(named: "placeholder")
        }
        DispatchQueue.main.async { [weak self] in
            
            self?.styleUI()
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            downloadView.layer.cornerRadius = downloadView.bounds.height / 2
            btnUpload.layer.cornerRadius = btnUpload.bounds.height / 2
        }
        exportView.cornerRadius =  UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
        exportView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        configureSegmentedControlAppearance(for: format)
        configureSegmentedControlAppearance(for: quality)
        addGestureDetector()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        collectionVIew.reloadData()
        DispatchQueue.main.async { [weak self] in
            
            self?.styleUI()
        }
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //    @objc func downloadViewTapped() {
    //        animateTopView()
    //        let selectedQualityIndex = quality.selectedSegmentIndex
    //        let selectedQualityTitle = quality.titleForSegment(at: selectedQualityIndex)
    //
    //        // Get the selected index and title of the format segmented control
    //        let selectedFormatIndex = format.selectedSegmentIndex
    //        let selectedFormatTitle = format.titleForSegment(at: selectedFormatIndex)
    //
    //        // Log or use the values
    //        print("Selected Quality: \(selectedQualityTitle ?? "None")")
    //        print("Selected Format: \(selectedFormatTitle ?? "None")")
    //    }
    //
    @IBAction func btnShare(_ sender: Any) {
        guard let image = previewImg.image else {
            let alert = UIAlertController(title: "No Image", message: "There is no image to share.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // For iPad: Prevent crash by specifying a popover presentation
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = (sender as? UIView)?.frame ?? CGRect.zero
        }
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func btnPro(_ sender: Any) {
        let vc = Storyboard.premium.instantiate(ProVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    func animateTopView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.downloadView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.downloadView.transform = .identity
            }
        }
    }
    
}

//  MARK: - UICOLLECTIONVIEW CELL
extension ExportVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        cell.img.image = UIImage(named: imgArr[indexPath.row])
        cell.imgBorder()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width  = collectionView.frame.width/3 - 10
        let height = collectionView.frame.height - 10
        let size  = min(width,height)
        
        return CGSize(width: width, height: size )
    }
    
}


// MARK: - STYLING UI

extension ExportVC {
    
    private func styleUI(){
        
        btnPro.layer.cornerRadius = btnPro.frame.height/2
        previewImg.layer.cornerRadius = previewImg.frame.height/6
        applyGradientToButton(
            button: btnPro,
            colors: [UIColor.kCream, UIColor.kDarkCream],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        
        
        
    }
    
    func configureSegmentedControlAppearance(for segmentedControl: UISegmentedControl) {
        
        var fontSize = 14
        if ( UIDevice.current.userInterfaceIdiom == .pad ){
            fontSize = 28
        }
        let unselectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Outfit-Medium", size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        ]
        segmentedControl.setTitleTextAttributes(unselectedAttributes, for: .normal)
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "Outfit-Medium", size: CGFloat(fontSize)) ?? UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        ]
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segmentedControl.layer.cornerRadius = segmentedControl.frame.height / 2
        segmentedControl.clipsToBounds = true
    }
    
    func addGestureDetector(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(downloadViewTapped))
        downloadView.addGestureRecognizer(tapGesture)
    }
    
}


// MARK: - Donwload Image Button Control UI
extension ExportVC {
    @objc func downloadViewTapped() {
        animateTopView()
        
        // Get selected quality
        let selectedQualityIndex = quality.selectedSegmentIndex
        let selectedQualityTitle = quality.titleForSegment(at: selectedQualityIndex) ?? "Regular"
        
        // Get selected format
        let selectedFormatIndex = format.selectedSegmentIndex
        let selectedFormatTitle = format.titleForSegment(at: selectedFormatIndex) ?? "JPG"
        
        print("Selected Quality: \(selectedQualityTitle)")
        print("Selected Format: \(selectedFormatTitle)")
        
        guard let image = previewImg.image else {
            print("No image to save")
            return
        }
        
        // Save image based on format and quality
        switch selectedFormatTitle {
        case "JPG", "JPEG":
            saveImageAsJPG(image: image, quality: selectedQualityTitle)
        case "PNG":
            saveImageAsPNG(image: image)
        case "PDF":
            savePDF(image: image)
        default:
            print("Unsupported format")
        }
    }
    
    func saveImageAsJPG(image: UIImage, quality: String) {
        // Determine the compression quality
        let compressionQuality: CGFloat
        switch quality {
        case "Regular":
            compressionQuality = 0.5
        case "Medium":
            compressionQuality = 0.75
        case "Max":
            compressionQuality = 1.0
        default:
            compressionQuality = 0.5
        }
        
        // Convert image to JPG data
        guard let jpgData = image.jpegData(compressionQuality: compressionQuality) else {
            print("Failed to convert image to JPG")
            return
        }
        
        // Save to gallery
        saveImageDataToGallery(data: jpgData, format: "jpg")
    }
    
    func saveImageAsPNG(image: UIImage) {
        // Convert image to PNG data
        
        
        guard let pngData = image.pngData() else {
            print("Failed to convert image to PNG")
            return
        }
        
        // Save to gallery
        saveImageDataToGallery(data: pngData, format: "png")
    }
    
    func saveImageAsPDF(image: UIImage) {
        // Create a PDF document with the image
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, image.size.rect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()!
        image.draw(in: image.size.rect)
        UIGraphicsEndPDFContext()
        
        // Save to gallery
        saveImageDataToGallery(data: pdfData as Data, format: "pdf")
    }
    
    
    
    //    func saveImageDataToGallery(data: Data, format: String) {
    //        // Temporary file URL
    //        let tempDirectory = FileManager.default.temporaryDirectory
    //        let fileURL = tempDirectory.appendingPathComponent("Image.\(format)")
    //
    //        do {
    //            // Write data to temporary file
    //            try data.write(to: fileURL)
    //
    //            // Save file to gallery
    //            UISaveVideoAtPathToSavedPhotosAlbum(fileURL.path, nil, nil, nil)
    //            print("\(format.uppercased()) file saved successfully!")
    //
    //        } catch {
    //            print("Failed to save \(format.uppercased()) file: \(error)")
    //        }
    //    }
    
    
    func saveImageDataToGallery(data: Data, format: String) {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("Image.\(format)")
        
        do {
            // Write data to temporary file
            try data.write(to: fileURL)
            
            if format.lowercased() == "jpg" || format.lowercased() == "png" {
                // Convert Data to UIImage
                if let image = UIImage(data: data) {
                    // Save image to gallery
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
                    print("\(format.uppercased()) file saved successfully to the gallery!")
                } else {
                    print("Failed to convert data to UIImage.")
                }
            }
            
            else if format.lowercased() == "pdf" {
                let fileManager = FileManager.default
                let fileName = "savePdf"
                guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    print("Unable to access the Documents Directory.")
                    return
                }
                
                // Create the file URL for the PDF
                let pdfURL = documentsDirectory.appendingPathComponent("\(fileName).pdf")
                
                do {
                    // Write the PDF data to the file
                    try data.write(to: pdfURL)
                    
                    print("PDF saved successfully at \(pdfURL.path)")
                } catch {
                    print("Failed to save PDF: \(error.localizedDescription)")
                }
                
            } else {
                print("Unsupported format: \(format.uppercased())")
            }
        } catch {
            print("Failed to save \(format.uppercased()) file: \(error)")
        }
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Failed to save image: \(error.localizedDescription)")
        } else {
            print("Image saved successfully!")
        }
    }
    
    
    
   
    
}

extension CGSize {
    var rect: CGRect {
        return CGRect(origin: .zero, size: self)
    }
}




extension ExportVC: UIDocumentPickerDelegate {

    func savePDF(image: UIImage) {
        // Create PDF Data
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, image.size.rect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()!
        image.draw(in: image.size.rect)
        UIGraphicsEndPDFContext()
        
        // Ask the user where to save the file
        if #available(iOS 14.0, *) {
            presentDocumentPicker(with: pdfData as Data)
        } else {
            // Fallback on earlier versions if necessary
            print("Fallback for earlier versions not implemented.")
        }
    }

    @available(iOS 14.0, *)
    func presentDocumentPicker(with data: Data) {
        // Create the UIDocumentPickerViewController to allow file export
        let temporaryFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temporaryFile.pdf")
        
        // Write the data to a temporary location first
        do {
            try data.write(to: temporaryFileURL)
        } catch {
            print("Error writing PDF to temporary file: \(error)")
            return
        }
        
        let documentPicker = UIDocumentPickerViewController(forExporting: [temporaryFileURL])
        documentPicker.modalPresentationStyle = .formSheet
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    // UIDocumentPickerDelegate method to handle saving the file
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Get the URL where the user chose to save the file
        let fileName = UUID().uuidString
        if let destinationURL = urls.first {
            do {
                // Copy the PDF from temporary location to the chosen location
                let temporaryFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(fileName).pdf")
                try FileManager.default.copyItem(at: temporaryFileURL, to: destinationURL)
                print("File saved to: \(destinationURL)")
            } catch {
                print("Error saving file: \(error)")
            }
        }
    }
    
    // Handle the case where the user cancels the file picker
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("User cancelled the file picker")
    }
}
