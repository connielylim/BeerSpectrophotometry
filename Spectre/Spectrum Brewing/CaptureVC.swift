//
//  ViewController.swift
//  Spectrum Brewing
//
//  Created by Connie Lim on 10/17/16.
//  Copyright © 2016 Capstone Fall 2016. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
//    var SRMarray:[Double] = []
    var picker = UIImagePickerController()
    var shutterButton = UIButton()
    //Source: Tasting Beer by Randy Mosher
    var pickerDataSource = ["Amber Ale 11-18",
                            "American Pale Ale 6-14",
                            "Baltic Porter 17-40",
                            "Bavarian Weizen 4-10",
                            "Belgian Strong Ale 4-7",
                            "Bière de Garde 6-13",
                            "Bitter, ESB 8-14",
                            "Bock 15-30",
                            "Dunkel Weizen 9-13",
                            "English Brown Ale 12-22",
                            "English Golden Ale 4-8",
                            "Foreign Stout 30-65",
                            "Imperial Pale Ale 5-11",
                            "Imperial Stout 50-80",
                            "Maibock 4-10",
                            "Märzen 7-15",
                            "Oatmeal Stout 25-40",
                            "Oktoberfest 4-12",
                            "Pale Ale 5-14",
                            "Pilsner 2-7",
                            "Porter 20-40",
                            "Vienna Lager 7-14",
                            "Witbier,Berliner Weisse 2-4"];
    
    //MARK: Picker View
    @IBOutlet weak var BeerTypePicker: UIPickerView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
        self.BeerTypePicker.dataSource = self
        self.BeerTypePicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerDataSource[row]
    }
    
    //MARK: camera util related
    func presentCamera(){
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
            assert(false, "can't run without camera")
        }
        
        picker.sourceType = .camera
        picker.showsCameraControls = true
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
        picker.cameraOverlayView = shutterButton
        present(picker, animated: true, completion: nil)
    }
    
    func takePhoto() {
        picker.updateFocusIfNeeded()
        picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.off
        picker.takePicture()
    }
    
    // MARK: ibaction
    @IBAction func showCamera(_ sender: UIButton) {
        presentCamera()
        
        self.perform(#selector(takePhoto), with: nil, afterDelay: 10)
//        let numOfPics = 1
//        while (numOfPics < 5){
//            self.perform(#selector(takePhoto), with: nil, afterDelay: 1)
//        }
        
    }
    
    func presentSRMResultVC(withVal SRMval:Double, withPic sampleImage:UIImage) {
        //MARK: SRMResultVC presented
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc: UINavigationController = storyboard.instantiateViewController(withIdentifier: "SRMResultVC") as! UINavigationController
        let vc = storyboard.instantiateViewController(withIdentifier: "SRMVC") as? SRMResultVC
        
        vc?.SRMnum = SRMval
        let chosen = pickerDataSource[BeerTypePicker.selectedRow(inComponent: 0)]
        vc?.beerTypeSRM = chosen
        vc?.beerImage = sampleImage
        UIApplication.shared.keyWindow?.rootViewController = vc
        
    }

    
    //MARK: UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let SRMval = getSRMValFrom(image: image)
            presentSRMResultVC(withVal:SRMval, withPic:image)
            
        }
    
    }
    
}

