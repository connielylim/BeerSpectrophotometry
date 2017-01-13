//
//  SRMResultVC.swift
//  Spectrum Brewing
//
//  Created by Connie Lim on 11/16/16.
//  Copyright © 2016 Capstone Fall 2016. All rights reserved.
//

import UIKit

public class SRMResultVC: UIViewController {

    @IBOutlet weak var SRMNumLabel: UILabel!
    
    @IBOutlet weak var pickerBeerTypeSRM: UILabel!
    @IBOutlet weak var beerUIImage: UIImageView!

    public var SRMnum: Double?
    public var beerTypeSRM: String?
    public var beerImage: UIImage?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        SRMNumLabel.text = String(format:"%.2f",SRMnum!)
        pickerBeerTypeSRM.text = beerTypeSRM!
        self.beerUIImage.image = beerImage
        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getIntFrom()->Int{
        
        return 1
    }
    func SRMLabelTextStyle(){
//        SRMNumLabel.
    }
    @IBAction func goTofirstView(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "firstVC") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
