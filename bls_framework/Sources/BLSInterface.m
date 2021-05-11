//
//  BLSInterface.m
//  bls_framework
//
//  Created by Mikhail Nikanorov on 12/3/20.
//  Copyright © 2020 MyEtherWallet Inc. All rights reserved.
//

#import "BLSInterface.h"

//#define BLS_ETH 1
#import <bls_framework/bn_c384_256.h>
#import <bls_framework/bls.h>


@implementation BLSInterface

+ (BOOL) blsInitWithError:(NSError **)error {
  __block int err = 0;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    err = blsInit(MCL_BLS12_381, MCLBN_COMPILED_TIME_VAR);
    if (err == 0) {
      // use the latest eth2.0 spec
      blsSetETHmode(BLS_ETH_MODE_OLD);
    }
  });
  if (err == 0) {
    return YES;
  }
  *error = [[NSError alloc] initWithDomain:@"BLS" code:err userInfo:nil];
  return NO;
}

@end
