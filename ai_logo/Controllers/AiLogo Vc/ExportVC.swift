//
//  ExportVc.swift
//  ai_logo
//
//  Created by LAP__TECH on 11/28/24.
//

import UIKit
import SDWebImage
import MobileCoreServices
import ProgressHUD

class ExportVC: UIViewController {
    
    @IBOutlet weak var exportBar: UIView!
    @IBOutlet weak var topBarHideStrip: UIImageView!
    @IBOutlet weak var textBackView: UIView!
    @IBOutlet weak var segmentationView: UIView!
    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var formatCollectionView: UICollectionView!
    @IBOutlet weak var qualityCollectionView: UICollectionView!
    
    
    @IBOutlet weak var quality: UISegmentedControl!
    @IBOutlet weak var format: UISegmentedControl!
    
    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var lblPrompt: UITextView!
    
    @IBOutlet weak var exportView: UIView!
    @IBOutlet weak var downloadView: UIView!
    @IBOutlet weak var haltView: UIView!
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var btnShowExportConfig: UIView!
    
    @IBOutlet weak var btnPro: UIButton!
    @IBOutlet weak var btnUpload: UIButton!
    
    @IBOutlet weak var maxProImg: UIImageView!
    @IBOutlet weak var mediumProImg: UIImageView!
    @IBOutlet weak var pdfProImg: UIImageView!
    @IBOutlet weak var pngProImg: UIImageView!
    
   
    let formatArr = ["JPG","PNG","PDF"]
    let qualityArr = ["Regular", "Medium","Max"]
   
    var selectedFormat :Int = 0
    var selectedQuality :Int = 0
    var imgUrl: String?
    var imgArr: [String] = []
    var imgPath: String?
    var isFromPreview: Bool = false
    var firstImg:String?
    var apiCount: Int = 0
    var imgName: [String] = []
    var prompt:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideViews()
        setupCollectionViews()
        loadPreviewImage()
        styleUIElements()
        configureSegmentedControls()
        addGestureDetector()
        hideProBadges()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        collectionVIew.reloadData()
      
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        if !isFromPreview{
            self.generateLogo(prompt: prompt )
        }
        else{
            let fileManager = FileManager.default
            if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                let imges = imgArr
                imgArr.removeAll()
                for imageName in imges {
                    let imageURL = documentsDirectory.appendingPathComponent("\(imageName).jpg")
                    let fullPath = imageURL.path
                    imgArr.append(fullPath)
                    
                    print("Full Path for \(imageName): \(fullPath)")
                }
                
                if imgArr.indices.contains(3) {
                    firstImg = (firstImg ?? "") + ".jpg"
                    let specificImagePath = documentsDirectory.appendingPathComponent(firstImg ?? "").path
                    firstImg = specificImagePath
                    print("Specific Path (imgArr[3]): \(specificImagePath)")
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        applyCornerRadius()
    }
  
    
    @IBAction func btnCancel(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
   
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
    
    @objc func btnShowExportConfigAction() {
        exportView.isHidden = false
        exportView.transform = CGAffineTransform(translationX: 0, y: exportView.frame.height)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.exportView.transform = .identity
        }, completion: nil)
        haltView.isHidden = false

    }

    @objc func haltViewAction() {
        closeExportConfig()

    }
    @objc func exportBarAction() {
        closeExportConfig()
        
    }
}

//  MARK: - UICOLLECTIONVIEW CELL
extension ExportVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == formatCollectionView {
            return formatArr.count
        }
        else if collectionView == qualityCollectionView {
            return qualityArr.count
        }
        else{
            return 3
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == formatCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FormatCell", for: indexPath) as! FormatCell
            cell.lblTitle.text = formatArr[indexPath.item]
            cell.backView.layer.cornerRadius = formatCollectionView.frame.height / 4
            
            if indexPath.item == selectedFormat {
                cell.backView.backgroundColor = .kWhite
                cell.lblTitle.textColor = .kBlack
            }
            else{
                cell.backView.backgroundColor = .clear
                cell.lblTitle.textColor = .kWhite
                
            }
            return cell
        }
        else if collectionView == qualityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FormatCell", for: indexPath) as! FormatCell
            cell.backView.layer.cornerRadius = qualityCollectionView.frame.height / 4
            
            cell.lblTitle.text = qualityArr[indexPath.item]
            if indexPath.item == selectedQuality {
                cell.backView.backgroundColor = .kWhite
                cell.lblTitle.textColor = .kBlack
            }
            else{
                cell.backView.backgroundColor = .clear
                cell.lblTitle.textColor = .kWhite
                
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
          
            if indexPath.row  < imgArr.count {
                let imgName = imgArr[indexPath.row]
                cell.img.image = UIImage(named: imgName)
                cell.indicator.isHidden = true
                cell.img.isHidden = false
                cell.animationView.isHidden = true
                cell.removeSubviews()


            } else {
                print("Index out of range: \(indexPath.row)")
//                cell.indicator.startAnimating()
//                cell.indicator.isHidden = false
                cell.img.isHidden = true
                cell.setupAnimation()


            }
            cell.imgBorder()
            cell.tryImg.isHidden = false
            cell.tryImg.image = UIImage(resource: .proBadge)
            if isProUser {
                cell.tryImg.isHidden = true
            }
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hapticFeedBackAction()
        if collectionView == formatCollectionView {
            if isProUser {
                selectedFormat = indexPath.item
                formatCollectionView.reloadData()
            }
            else {
                presentProVc()
            }
        }
        else if collectionView == qualityCollectionView {
            if isProUser {
                selectedQuality = indexPath.item
                qualityCollectionView.reloadData()
            }
            else{
                presentProVc()
            }
        }
        else {
          
            if isProUser {
                previewImg.image = UIImage(contentsOfFile: imgArr[indexPath.row])
                applyCornerRadius()

                let oldImagePath = imgArr[indexPath.row]
                imgArr[indexPath.row] = firstImg ?? ""
                firstImg = oldImagePath
                collectionView.reloadItems(at: [indexPath])

                
            }
            else {
                presentProVc()
            }

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == formatCollectionView || collectionView == qualityCollectionView {
            let width  = collectionView.frame.width/3 - 10
            
            return CGSize(width: width, height: collectionView.frame.height )
        }
        else{
            let width  = collectionView.frame.width/3 - 10
            let height = collectionView.frame.height - 10
            let size  = min(width,height)
            
            return CGSize(width: width, height: size )
        }
    }
    
}


// MARK: - STYLING UI

extension ExportVC {
    
    private func hideProBadges() {
        if isProUser {
            maxProImg.isHidden = true
            mediumProImg.isHidden = true
            pdfProImg.isHidden = true
            pngProImg.isHidden = true
            
        }
        
    }
    
    private func hideViews() {
        haltView.isHidden = true
        exportView.isHidden = true
        segmentationView.isHidden = true
    }
    
    private func configureSegmentedControls() {
        configureSegmentedControlAppearance(for: format)
        configureSegmentedControlAppearance(for: quality)
    }
    
    private func styleUIElements() {
        DispatchQueue.main.async { [weak self] in
            self?.styleUI()
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            downloadView.layer.cornerRadius = downloadView.bounds.height / 2
            btnUpload.layer.cornerRadius = btnUpload.bounds.height / 2
            textBackView.layer.cornerRadius = textBackView.frame.height / 3
            btnShowExportConfig.layer.cornerRadius = btnShowExportConfig.frame.height / 2
        }
        
        
       
        exportView.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
        exportView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func setupCollectionViews() {
        // Register cells
        let projectNib = UINib(nibName: "ProjectCell", bundle: nil)
        collectionVIew.register(projectNib, forCellWithReuseIdentifier: "ProjectCell")
        
        let formatNib = UINib(nibName: "FormatCell", bundle: nil)
        formatCollectionView.register(formatNib, forCellWithReuseIdentifier: "FormatCell")
        qualityCollectionView.register(formatNib, forCellWithReuseIdentifier: "FormatCell")
        
        // Set delegates and data sources
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        
        formatCollectionView.delegate = self
        formatCollectionView.dataSource = self
        
        qualityCollectionView.delegate = self
        qualityCollectionView.dataSource = self
        
        if !isFromPreview {
        collectionVIew.isUserInteractionEnabled = false
        }
    }
    
    private func loadPreviewImage() {
        guard let imgUrl = imgUrl, let url = URL(string: imgUrl) else {
            previewImg.image = UIImage(named: "placeholder")
            ProgressHUD.dismiss()
            return
        }
        previewImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
        ProgressHUD.dismiss()
    }
    
    private func styleUI(){
        
        btnPro.layer.cornerRadius = btnPro.frame.height/2
        previewImg.layer.cornerRadius = previewImg.frame.height/6
        applyGradientToButton(
            button: btnPro,
            colors: [UIColor.kCream, UIColor.kDarkCream],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        formatCollectionView.layer.cornerRadius = formatCollectionView.frame.height / 4
        qualityCollectionView.layer.cornerRadius = qualityCollectionView.frame.height / 4
       
        if isProUser {
            btnPro.isHidden = true
        }
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
        
        
        let btnShowExportConfigTap = UITapGestureRecognizer(target: self, action: #selector(btnShowExportConfigAction))
        btnShowExportConfig.addGestureRecognizer(btnShowExportConfigTap)
        
        let haltViewTap = UITapGestureRecognizer(target: self, action: #selector(haltViewAction))
        haltView.addGestureRecognizer(haltViewTap)
        
        let exportBarTap = UITapGestureRecognizer(target: self, action: #selector(exportBarAction))
        exportBar.addGestureRecognizer(exportBarTap)
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
    
    private func presentProVc() {
        let vc  = Storyboard.premium.instantiate(ProVC.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func closeExportConfig() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.exportView.transform = CGAffineTransform(translationX: 0, y: self.exportView.frame.height)
        }, completion: { _ in
            self.exportView.isHidden = true
        })
        haltView.isHidden = true
    }
    
    private func applyCornerRadius() {
        guard let originalImage = previewImg.image else { return }
        previewImg.image = originalImage.withRoundedCorners()
        previewImg.clipsToBounds = true
    }

}

// MARK: - Donwload Image Button Control UI
extension ExportVC {
    @objc func downloadViewTapped() {
        animateTopView()
        
        // Get selected quality
        let selectedQualityIndex = quality.selectedSegmentIndex
        //        let selectedQualityTitle = quality.titleForSegment(at: selectedQualityIndex) ?? "Regular"
        let selectedQualityTitle = qualityArr[selectedQuality]
        
        // Get selected format
        let selectedFormatIndex = format.selectedSegmentIndex
        //        let selectedFormatTitle = format.titleForSegment(at: selectedFormatIndex) ?? "JPG"
        let selectedFormatTitle = formatArr[selectedFormat]
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
        saveImageDataToGallery(data: jpgData, format: "jpg",viewController: self)
    }
    
    func saveImageAsPNG(image: UIImage) {
        // Convert image to PNG data
        
        
        guard let pngData = image.pngData() else {
            print("Failed to convert image to PNG")
            return
        }
        
        // Save to gallery
        saveImageDataToGallery(data: pngData, format: "png",viewController: self)
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
        saveImageDataToGallery(data: pdfData as Data, format: "pdf",viewController: self)
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
    
    
    
    func saveImageDataToGallery(data: Data, format: String, viewController: UIViewController) {
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
                    showAlert(title: "Success", message: "\(format.uppercased()) file saved successfully to the gallery!", viewController: self)
                } else {
                    showAlert(title: "Error", message: "Failed to convert data to UIImage.",viewController: self)
                }
            } else if format.lowercased() == "pdf" {
                let fileManager = FileManager.default
                let fileName = "savePdf"
                guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    showAlert(title: "Error", message: "Unable to access the Documents Directory.",viewController: self)
                    return
                }
                
                // Create the file URL for the PDF
                let pdfURL = documentsDirectory.appendingPathComponent("\(fileName).pdf")
                
                do {
                    // Write the PDF data to the file
                    try data.write(to: pdfURL)
                    showAlert(title: "Success", message: "PDF saved successfully at \(pdfURL.path)",viewController: self)
                } catch {
                    showAlert(title: "Error", message: "Failed to save PDF: \(error.localizedDescription)",viewController: self)
                }
            } else {
                showAlert(title: "Error", message: "Unsupported format: \(format.uppercased())",viewController: self)
            }
        } catch {
            showAlert(title: "Error", message: "Failed to save \(format.uppercased()) file: \(error.localizedDescription)",viewController: self)
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

//  MARK: CALL API
extension ExportVC {
    private func generateLogo(prompt: String) {
        
        if apiCount < 3{
            APIManager.shared.generateLogo(prompt: prompt) { result in
                DispatchQueue.main.async { [self] in
                    switch result {
                    case .success(let response):
                        print("Logo Generation Results:")
                        print("Cost:", response.cost)
                        print("Seed:", response.seed)
                        print("Logo URL:", response.url)
                        
                        
                        let imgName = UUID().uuidString
                        
                        
                        CoreDataManager.shared.saveImageFromURLToDocumentsDirectory(response.url, withName: imgName) { [self] savedPath in
                            if let path = savedPath {
                                DispatchQueue.main.async {
                                    self.apiCount += 1
                                    
                                    self.imgArr.append(path)
                                    self.imgName.append(imgName)
                                    
                                    self.collectionVIew.reloadData()
                                    self.generateLogo(prompt: prompt)
                                    
                                }
                                
                            }
                            
                            
                        }
                    case .failure(let error):
                        print("Error:", error.localizedDescription)
                        
                        // Show an alert to the user if needed
                    }
                }
            }
        }
        else{
            print("Api limit reached : \(apiCount) ")
            if let imgPath = imgPath{
                imgArr.append(imgPath)
                imgName.append(imgPath)

                CoreDataManager.shared.saveRecord(prompt: lblPrompt.text, imgPath: imgName)
                collectionVIew.isUserInteractionEnabled = true

            }
        }
    }

}
