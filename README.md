Here is the link to the Objective-C version 
[Objective-C version  By Clément Wehrung](https://github.com/iclems/iOS-htmltopdf)

iOS-htmltopdf
=============
Donate to support the author : 
[<img src="https://www.paypal.com/en_US/i/btn/btn_donateCC_LG.gif">](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=P9MWVQ5H6PP5L)

This class enables simple URL-based PDF creation. Pages are created the exact same way they would be if the user printed the content on an iOS device (very similar as well as OS X print output).

Example code:

```

    self.PDFCreator = NDHTMLtoPDF.createPDFWithURL(
        NSURL(string:"http://url.com")!, p
        athForPDF:tt, 
        delegate: self, 
        pageSize: CGSizeMake(595.2,841.8), 
        margins:UIEdgeInsetsMake(10, 5, 10, 5)) 
        as? NDHTMLtoPDF
```

or using block syntax

```
    self.PDFCreator = NDHTMLtoPDF.createPDFWithURL(NSURL(string:"http://url.com")! , 
    pathForPDF:"~/Documents/blocksDemo.pdf".stringByExpandingTildeInPath, 
    pageSize:CGSizeMake(595.2,841.8), margins:UIEdgeInsetsMake(10, 5, 10, 5), 
    successBlock: {( htmlToPDF:NDHTMLtoPDF) in
            var result:NSString  = NSString(format:"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath!)
            NSLog("%@",result);
            self.resultLabel!.text = result as String;
        } , 
    errorBlock:{(htmlToPDF:NDHTMLtoPDF) in
            var result:NSString   = NSString(format:"HTMLtoPDF did fail (%@)", htmlToPDF);
        
            NSLog("%@",result);
        self.resultLabel!.text = result as String;
    }) as? NDHTMLtoPDF;
```

You can also use the alternative following code to generate PDF directly from HTML string, without using an URL. This is useful if you want your PDF generator to work offline or if you don't want to write first your code into a local file (you can then use NSURL with a local file through fileURLWithPath:) :

```
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
```

A paper size is only defined by a rect (e.g. kPaperSizeA4 CGSizeMake(595.2,841.8)).

Please, be sure to create a property (e.g. `PDFCreator`) as NDHTMLtoPDF works asynchronously using UIWebView.

Feel free to contact us or to contact the orinal author if you have any question !

[@cwehrung](https://twitter.com/cwehrung)

[@myappconverter](https://twitter.com/myappconverter)
