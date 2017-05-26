//
//  Olli.h
//
//  Created by Wes inspired by Aaron Thorp on 27.04.16.
//  http://aaronthorp.com
//

#import "Olli.h"

@interface Olli()


@end

@implementation Olli

- (void)initOlli:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;

    if (!ollidev) {
        ollidev = [GTMagBarDevice sharedDevice];
        ollidev.delegate = self;
        // [self fireEvent:@"magtek_swipe_success" withData:cardData];
        //ollidev.delegate = self;
        //[ollidev connect];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)startScan:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;

    [ollidev startScan];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)magbarDevice:(GTMagBarDevice*)ollidev accessoryConnected:(BOOL)state {

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

- (void)magbarDevice:(GTMagBarDevice*)device receivedBarcodeData:(NSString*)data barcodeType:(NSInteger*)barcodeType {
  NSString* retStr = [ NSString stringWithFormat:@"Olli.onBarcodeData('%@');", data];
 [self.webViewEngine evaluateJavaScript:retStr completionHandler:nil];
}

- (void)magbarDevice:(GTMagBarDevice*)device receivedMagneticStripeData:(NSDictionary*)data {
  NSString *track1 = [data objectForKey:kTrack1Clear];
  NSString *track2 = [data objectForKey:kTrack2Clear];
  NSString *track3 = [data objectForKey:kTrack3Clear];
  
  NSString* retStr = [ NSString stringWithFormat:@"Olli.onMagneticCardData('%@', '%@', '%@');", track1, track2, track3];
  [self.webViewEngine evaluateJavaScript:retStr completionHandler:nil];
}


@end
