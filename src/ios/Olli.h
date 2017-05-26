//
//  Olli.h
//
//  Created by Wes inspired by Aaron Thorp
//  http://aaronthorp.com
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>

#import "GTMagBarDevice.h"
#import "GTMagBarDevice+AllowFinancialOnUnencryptedReadHead.h"

@interface Olli : CDVPlugin <GTMagBarDeviceDelegate>
{
    GTMagBarDevice *ollidev;
}

- (void)initOlli:(CDVInvokedUrlCommand*)command;
- (void)startScan:(CDVInvokedUrlCommand*)command;

@end
