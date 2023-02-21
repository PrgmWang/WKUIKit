//
//  WKUIHelper.m
//  WKUIKit
//
//  Created by Prgm、Wang on 2022/4/8.
//

#import "WKUIHelper.h"

@implementation WKUIHelper

static NSMutableSet<NSString *> *executedIdentifiers;
+ (BOOL)executeBlock:(void (NS_NOESCAPE ^)(void))block oncePerIdentifier:(NSString *)identifier {
    if (!block || identifier.length <= 0) return NO;
    @synchronized (self) {
        if (!executedIdentifiers) {
            executedIdentifiers = NSMutableSet.new;
        }
        if (![executedIdentifiers containsObject:identifier]) {
            [executedIdentifiers addObject:identifier];
            block();
            return YES;
        }
        return NO;
    }
}

@end
