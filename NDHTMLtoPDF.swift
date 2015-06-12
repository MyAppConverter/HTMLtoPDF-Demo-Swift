//
//  NDHTMLtoPDF.m
//  Nurves
//
//  Created by Clement Wehrung on 31/10/12.
//  Copyright (c) 2012-2014 Clement Wehrung. All rights reserved.
//
//  Released under the MIT license
//
//  Contact cwehrung@nurves.com for any question.
//
//  Sources : http://www.labs.saachitech.com/2012/10/23/pdf-generation-using-uiprintpagerenderer/
//  Addons : http://developer.apple.com/library/ios/#samplecode/PrintWebView/Listings/MyPrintPageRenderer_m.html#//apple_ref/doc/uid/DTS40010311-MyPrintPageRenderer_m-DontLinkElementID_7

//  *******************************************************************************************
//  *                                                                                         *
//  **This code has been automaticaly ported to Swift language1.2 using MyAppConverter.com   **
//  *                                     11/06/2015                                          *
//  *******************************************************************************************

import UIKit

typealias NDHTMLtoPDFCompletionBlock = (htmlToPDF:NDHTMLtoPDF) -> Void

protocol NDHTMLtoPDFDelegate{
    func HTMLtoPDFDidSucceed( htmlToPDF:NDHTMLtoPDF )
    func HTMLtoPDFDidFail( htmlToPDF:NDHTMLtoPDF )
}

class NDHTMLtoPDF :UIViewController,UIWebViewDelegate
{
    var PDFpath:NSString?
    var successBlock:NDHTMLtoPDFCompletionBlock?
    var delegate:AnyObject?/////////NDHTMLtoPDFDelegate?
    var PDFdata:NSData?
    var errorBlock:NDHTMLtoPDFCompletionBlock?
    var URL:NSURL?
    var HTML:NSString?
    var webview:UIWebView?
    var pageSize:CGSize?
    var pageMargins:UIEdgeInsets?
    
    func createPDFWithURL( URL:NSURL ,pathForPDF PDFpath:NSString ,delegate:AnyObject ,pageSize:CGSize ,margins pageMargins:UIEdgeInsets )->AnyObject{
        var creator:NDHTMLtoPDF = NDHTMLtoPDF(URL:URL , delegate: delegate , pathForPDF: PDFpath , pageSize: pageSize , margins: pageMargins )
        
        return creator
        
    }
    func createPDFWithHTML( HTML:NSString ,pathForPDF PDFpath:NSString ,delegate:AnyObject ,pageSize:CGSize ,margins pageMargins:UIEdgeInsets )->AnyObject{
        var creator:NDHTMLtoPDF = NDHTMLtoPDF(HTML:HTML , baseURL: nil , delegate: delegate , pathForPDF: PDFpath , pageSize: pageSize , margins: pageMargins )
        
        return creator
        
    }
    func createPDFWithHTML( HTML:NSString ,baseURL:NSURL ,pathForPDF PDFpath:NSString ,delegate:AnyObject ,pageSize:CGSize ,margins pageMargins:UIEdgeInsets )->AnyObject{
        var creator:NDHTMLtoPDF = NDHTMLtoPDF(HTML:HTML , baseURL: baseURL , delegate: delegate , pathForPDF: PDFpath , pageSize: pageSize , margins: pageMargins )
        
        return creator
        
    }
    func createPDFWithURL( URL:NSURL ,pathForPDF PDFpath:NSString ,pageSize:CGSize ,margins pageMargins:UIEdgeInsets ,successBlock:NDHTMLtoPDFCompletionBlock ,errorBlock:NDHTMLtoPDFCompletionBlock )->AnyObject{
        var creator:NDHTMLtoPDF = NDHTMLtoPDF(URL:URL , delegate: nil , pathForPDF: PDFpath , pageSize: pageSize , margins: pageMargins )
        
        creator.successBlock = successBlock
        creator.errorBlock = errorBlock
        return creator
        
    }
    func createPDFWithHTML( HTML:NSString ,pathForPDF PDFpath:NSString ,pageSize:CGSize ,margins pageMargins:UIEdgeInsets ,successBlock:NDHTMLtoPDFCompletionBlock ,errorBlock:NDHTMLtoPDFCompletionBlock )->AnyObject{
        var creator:NDHTMLtoPDF = NDHTMLtoPDF(HTML:HTML , baseURL: nil , delegate: nil , pathForPDF: PDFpath , pageSize: pageSize , margins: pageMargins )
        
        creator.successBlock = successBlock
        creator.errorBlock = errorBlock
        return creator
        
    }
    func createPDFWithHTML( HTML:NSString ,baseURL:NSURL ,pathForPDF PDFpath:NSString , pageSize:CGSize ,margins pageMargins:UIEdgeInsets ,successBlock:NDHTMLtoPDFCompletionBlock ,errorBlock:NDHTMLtoPDFCompletionBlock )->AnyObject{
        var creator:NDHTMLtoPDF = NDHTMLtoPDF(HTML: HTML , baseURL: baseURL , delegate: nil , pathForPDF: PDFpath , pageSize: pageSize , margins: pageMargins )
        creator.successBlock = successBlock
        creator.errorBlock = errorBlock
        return creator
        
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.PDFdata = nil
        
    }
    
    init( URL:NSURL? ,delegate:AnyObject? ,pathForPDF PDFpath:NSString? ,pageSize:CGSize? ,margins pageMargins:UIEdgeInsets? ){
        super.init(nibName:nil, bundle:nil)
        self.URL = URL!
        self.delegate = delegate
        self.PDFpath = PDFpath!
        self.pageMargins = pageMargins!
        self.pageSize = pageSize!
        self.forceLoadView()
        
        
    }
    init( HTML:NSString ,baseURL:NSURL? ,delegate:AnyObject? ,pathForPDF PDFpath:NSString? ,pageSize:CGSize? ,margins pageMargins:UIEdgeInsets? ){
        super.init(nibName:nil, bundle:nil)
        self.HTML = HTML
        self.URL = baseURL!
        self.delegate = delegate
        self.PDFpath = PDFpath!
        self.pageMargins = pageMargins!
        self.pageSize = pageSize!
        self.forceLoadView()
        
    }
    func forceLoadView(){
        UIApplication.sharedApplication().delegate!.window!!.addSubview(self.view )
        self.view.frame = CGRectMake( 0 ,  0 ,  1 ,  1 )
        self.view.alpha =  0.000000
        
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        self.webview = UIWebView(frame: self.view.frame )
        webview!.delegate = self
        self.view.addSubview(webview! )
        if self.HTML == nil  {
            webview!.loadRequest(NSURLRequest(URL:self.URL! )  )
            
            
        }else {
            webview!.loadHTMLString(self.HTML as! String , baseURL:self.URL)
            
        }
        
        
    }
    func webViewDidFinishLoad( webView:UIWebView ){
        if webView.loading {
            
            return
            
        }
        
        var render:UIPrintPageRenderer = UIPrintPageRenderer()
        
        render.addPrintFormatter(webView.viewPrintFormatter() , startingAtPageAtIndex: 0 )
        var printableRect:CGRect = CGRectMake(self.pageMargins!.left , self.pageMargins!.top , self.pageSize!.width - self.pageMargins!.left  - self.pageMargins!.right  , self.pageSize!.height - self.pageMargins!.top  - self.pageMargins!.bottom  )
        
        var paperRect:CGRect = CGRectMake( 0 ,  0 , self.pageSize!.width , self.pageSize!.height )
        
        render.setValue(NSValue(CGRect: paperRect )  , forKey:"paperRect" )
        render.setValue(NSValue(CGRect: printableRect )  , forKey:"printableRect" )
        self.PDFdata = render.printToPDF()
        if (self.PDFpath != nil) {
            self.PDFdata?.writeToFile(self.PDFpath as! String , atomically:true )
            
            
        }
        
        self.terminateWebTask()
        if (self.delegate != nil) && (self.delegate! as! UIViewController).respondsToSelector(Selector("HTMLtoPDFDidSucceed:") )   {
            (self.delegate! as! NDHTMLtoPDFDelegate).HTMLtoPDFDidSucceed(self )
            
            
        }
        
        if (self.successBlock != nil) {
            self.successBlock!(htmlToPDF: self);
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error:NSError)
    {
        if webView.loading {
            return
        }
        
        self.terminateWebTask()
        
        if self.delegate != nil && self.delegate!.respondsToSelector(Selector("HTMLtoPDFDidFail"))
        {
            (self.delegate! as! NDHTMLtoPDFDelegate).HTMLtoPDFDidFail(self)
        }
        
        if (self.errorBlock != nil) {
            self.errorBlock!(htmlToPDF: self)
        }
        
    }
    
    func terminateWebTask()
    {
        self.webview!.stopLoading()
        self.webview!.delegate = nil
        self.webview!.removeFromSuperview()
        
        self.view.removeFromSuperview()
        
        self.webview = nil
    }
    
}

extension UIPrintPageRenderer
{
    func printToPDF()->NSData
    {
        var pdfData:NSMutableData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, self.paperRect,nil )
        
        self.prepareForDrawingPages(NSMakeRange(0, self.numberOfPages()))
        
        var bounds:CGRect  = UIGraphicsGetPDFContextBounds()
        
        for var i:Int = 0 ; i < self.numberOfPages() ; i++
        {
            UIGraphicsBeginPDFPage()
            
            self.drawPageAtIndex(i, inRect:bounds)
        }
        
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
    
}