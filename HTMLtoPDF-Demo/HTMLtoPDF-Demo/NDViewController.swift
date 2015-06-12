

import UIKit
//
//  NDViewController.m
//  HTMLtoPDF-Demo
//
//  Created by Clément Wehrung on 12/11/12.
//  Copyright (c) 2012 Nurves. All rights reserved.
//
//  *******************************************************************************************
//  *                                                                                         *
//  **This code has been automaticaly ported to Swift language 1.2 using MyAppConverter.com  **
//  *                                     11/06/2015                                          *
//  *******************************************************************************************
class NDViewController :UIViewController, NDHTMLtoPDFDelegate
{
    @IBOutlet weak var resultLabel:UILabel?
    var PDFCreator:NDHTMLtoPDF?

    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    @IBAction func generatePDFUsingDelegate( sender:AnyObject ){
        self.resultLabel?.text = "loading..."
        var tt:NSString = "~/Documents/delegateDemo.pdf".stringByExpandingTildeInPath
        self.PDFCreator = NDHTMLtoPDF.createPDFWithURL(NSURL(string:"http://edition.cnn.com/2012/11/12/business/china-consumer-economy/index.html?hpt=hp_c1")!, pathForPDF:tt, delegate: self, pageSize: CGSizeMake(595.2,841.8), margins:UIEdgeInsetsMake(10, 5, 10, 5)) as? NDHTMLtoPDF;
    }
    @IBAction func generatePDFUsingBlocks( sender:AnyObject ){
        self.resultLabel?.text = "loading..."
        
        self.PDFCreator = NDHTMLtoPDF.createPDFWithURL(NSURL(string:"http://edition.cnn.com/2013/09/19/opinion/rushkoff-apple-ios-baby-steps/index.html")! , pathForPDF:"~/Documents/blocksDemo.pdf".stringByExpandingTildeInPath, pageSize:CGSizeMake(595.2,841.8), margins:UIEdgeInsetsMake(10, 5, 10, 5), successBlock: {( htmlToPDF:NDHTMLtoPDF) in
            var result:NSString  = NSString(format:"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath!);
        
            NSLog("%@",result);
            self.resultLabel!.text = result as String;
        } , errorBlock:{(htmlToPDF:NDHTMLtoPDF) in
            var result:NSString   = NSString(format:"HTMLtoPDF did fail (%@)", htmlToPDF);
        
            NSLog("%@",result);
        self.resultLabel!.text = result as String;
        }) as? NDHTMLtoPDF;
        
    }
    
    func HTMLtoPDFDidSucceed( htmlToPDF:NDHTMLtoPDF ){
        var result:NSString? = NSString(format:"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath!);
        
        NSLog("%@" , result! )
        self.resultLabel?.text = result as? String
        
    }
    func HTMLtoPDFDidFail( htmlToPDF:NDHTMLtoPDF ){
        var result:NSString = NSString(format:"HTMLtoPDF did fail (%@)" , htmlToPDF )
        
        NSLog("%@" , result ) 
        self.resultLabel?.text = result as String
        
    }
}