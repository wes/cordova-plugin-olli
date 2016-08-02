//
//  GTMagBarDevice+AllowFinancialOnUnencryptedReadHead.h
//  MagBarSDK
//
//  Created by Jonathan Wiley on 7/19/14.
//  Copyright (c) 2014 Griffin Technology. All rights reserved.
//

#import "GTMagBarDevice.h"

@interface GTMagBarDevice (AllowFinancialOnUnencryptedReadHead)

- (void)setAllowFinancialOnUnencryptedReadHead:(BOOL)bAllow;
- (BOOL)getAllowFinancialOnUnencryptedReadHead;

@end
