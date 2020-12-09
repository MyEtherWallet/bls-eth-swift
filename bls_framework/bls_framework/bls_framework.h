//
//  bls_framework.h
//  bls_framework
//
//  Created by Mikhail Nikanorov on 12/1/20.
//  Copyright © 2020 MyEtherWallet Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for bls_framework.
FOUNDATION_EXPORT double bls_frameworkVersionNumber;

//! Project version string for bls_framework.
FOUNDATION_EXPORT const unsigned char bls_frameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <bls_framework/PublicHeader.h>

#define BLS_ETH
#import <bls_framework/BLSInterface.h>
#import <bls_framework/bn_c384_256.h>
#import <bls_framework/bls.h>
