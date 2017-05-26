//
//  Olli.h
//
//  Created by Wes inspired by Aaron Thorp on 27.04.16.
//  http://aaronthorp.com
//

#import "Olli.h"

@interface Olli()

    //GTMagBarDevice *ollidev;

@end

@implementation Olli

// -(void) scannerConect:(NSString*)num {
// 
//     NSString *jsStatement = [NSString stringWithFormat:@"reportConnectionStatus('%@');", num];
//     [self.webViewEngine evaluateJavaScript:jsStatement completionHandler:nil];
//     //[self.webView stringByEvaluatingJavaScriptFromString:jsStatement];
// 
// }

// -(void) scannerBattery:(NSString*)num {
// 
//     int percent;
//     float voltage;
// 
// 	if([dtdev getBatteryCapacity:&percent voltage:&voltage error:nil])
//     {
//         NSString *status = [NSString stringWithFormat:@"Bat: %.2fv, %d%%",voltage,percent];
// 
//         // send to web view
//         NSString *jsStatement = [NSString stringWithFormat:@"reportBatteryStatus('%@');", status];
//         [self.webViewEngine evaluateJavaScript:jsStatement completionHandler:nil];
//         //[self.webView stringByEvaluatingJavaScriptFromString:jsStatement];
// 
//     }
// }

// -(void) scanPaymentCard:(NSString*)num {
// 
//     NSString *jsStatement = [NSString stringWithFormat:@"onSuccessScanPaymentCard('%@');", num];
//     [self.webViewEngine evaluateJavaScript:jsStatement completionHandler:nil];
//     //[self.webView stringByEvaluatingJavaScriptFromString:jsStatement];
// 	  //[self.viewController dismissViewControllerAnimated:YES completion:nil];
// 
// }

- (void)initOlli:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSLog(@"OLLI INIT");
    if (!ollidev) {
        NSLog(@"OLLI INIT CONDITIONAL");
        self.ollidev = [GTMagBarDevice sharedDevice];
        ollidev.delegate = self;

    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)magbarDevice:(GTMagBarDevice*)ollidev accessoryConnected:(BOOL)state {
    
    NSLog(@"OLLI DEVICE CONNECTED %@", state);

    if(state == YES){
      [ollidev setScannerEnabled:YES];
      [ollidev setTimeout:5];
      [ollidev setChargingEnabled: YES];
      [ollidev setMagCardEnabled: YES];      
      [ollidev setBarcodeEnabled:0 enabled:YES];
      [ollidev setAllowFinancialOnUnencryptedReadHead: YES];
    }

    // CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:connected];
    NSString* retStr = [ NSString stringWithFormat:@"Olli.connectionChanged(%d);", state];
   [self.webViewEngine evaluateJavaScript:retStr completionHandler:nil];
    
}

// - (void)getConnectionStatus:(CDVInvokedUrlCommand*)command
// {
//     
//     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
// }

- (void)startBarcode:(CDVInvokedUrlCommand *)command
{
    [ollidev startScanWithLeadingTargetTime: 0.5];

    // [dtdev barcodeStartScan:nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:1];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stopBarcode:(CDVInvokedUrlCommand *)command
{
    [ollidev abortScan];

    // [dtdev barcodeStopScan:nil];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:1];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// - (void)connectionState: (int)state {
//     NSLog(@"connectionState: %d", state);
// 
//     switch (state) {
// 		case CONN_DISCONNECTED:
// 		case CONN_CONNECTING:
//                 break;
// 		case CONN_CONNECTED:
// 		{
// 			NSLog(@"PPad connected!\nSDK version: %d.%d\nHardware revision: %@\nFirmware revision: %@\nSerial number: %@", dtdev.sdkVersion/100,dtdev.sdkVersion%100,dtdev.hardwareRevision,dtdev.firmwareRevision,dtdev.serialNumber);
// 			break;
// 		}
// 	}
// 
//     NSString* retStr = [ NSString stringWithFormat:@"LineaProCDV.connectionChanged(%d);", state];
    // [self.webViewEngine evaluateJavaScript:retStr completionHandler:nil];
    //[[super webView] stringByEvaluatingJavaScriptFromString:retStr];
// }

// -(void)magbarDevice:(GTMagBarDevice *)device receivedBarcodeData:(NSString *)data barcodeType:(NSInteger)barcodeType {
//     
//     [self didRecieveBarcode:data];
//     
//     NSString *path = [[NSBundle mainBundle] pathForResource:@"scanbeep" ofType:@"wav"];
//     
//     theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
//     theAudio.delegate = self;
//     [theAudio play];
// 
// }
// 
// - (void)magbarDevice:(GTMagBarDevice*)device receivedMagneticStripeData:(NSDictionary*)data {
// 
// //    [self alert:[data objectForKey:kTrack1Clear]];
//     
//     NSDictionary *processedCard = [financialCard msProcessFinancialCard: [data objectForKey: kTrack1Clear] track2:[data objectForKey: kTrack2Clear]];
//     if(processedCard == nil){
//         [self alert:@"Card Could Not Be Read"];
//     }else{
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"CardSwipe" object:self userInfo:processedCard];
//     }
//     
// }

// - (void)magbarDevice:(GTMagBarDevice*)device receivedBadStripeData:(BOOL)bAlwaysYes {
    // [self alert:@"Could not read credit card"];
// }


@end
