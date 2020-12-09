//
//  BLSInterface.h
//  bls_framework
//
//  Created by Mikhail Nikanorov on 12/3/20.
//  Copyright © 2020 MyEtherWallet Inc. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface BLSInterface : NSObject
+ (BOOL) blsInitWithError:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
