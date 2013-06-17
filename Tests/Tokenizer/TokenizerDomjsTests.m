// This file was autogenerated from Tests/html5lib/tokenizer/domjs.test.

#import <SenTestingKit/SenTestingKit.h>
#import "HTMLTokenizerTestUtilities.h"

@interface TokenizerDomjsTests : SenTestCase

@end

@implementation TokenizerDomjsTests
        
- (void)test0
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@"ParseError",@[@"Comment",@"?\n"]]);
    for (NSString *state in @[@""]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"<?\r" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"CR in bogus comment state");
    }
}
        
- (void)test1
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@"ParseError",@[@"Comment",@"?\n"]]);
    for (NSString *state in @[@""]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"<?\r\n" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"CRLF in bogus comment state");
    }
}
        
- (void)test2
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@"ParseError",@[@"Character",@"\U0000FFFD"]]);
    for (NSString *state in @[@"RCDATA state",@"RAWTEXT state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"\x00" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"NUL in RCDATA and RAWTEXT");
    }
}
        
- (void)test3
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"Character",@"﻿foo﻿bar"]]);
    for (NSString *state in @[@""]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"﻿foo﻿bar" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"leading U+FEFF must pass through");
    }
}
        
- (void)test4
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"Character",@"≂̸"]]);
    for (NSString *state in @[@"RCDATA state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"&NotEqualTilde;" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"Non BMP-charref in in RCDATA");
    }
}
        
- (void)test5
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@"ParseError",@[@"Character",@"&NotEqualTild;"]]);
    for (NSString *state in @[@"RCDATA state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"&NotEqualTild;" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"Bad charref in in RCDATA");
    }
}
        
- (void)test6
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"EndTag",@"xmp"]]);
    for (NSString *state in @[@"RCDATA state",@"RAWTEXT state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"</XMP>" state:StateNamed(state)];
        [tokenizer setLastStartTag:@"xmp"];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"lowercase endtags in RCDATA and RAWTEXT");
    }
}
        
- (void)test7
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"Character",@"</ XMP>"]]);
    for (NSString *state in @[@"RCDATA state",@"RAWTEXT state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"</ XMP>" state:StateNamed(state)];
        [tokenizer setLastStartTag:@"xmp"];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"bad endtag in RCDATA and RAWTEXT");
    }
}
        
- (void)test8
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"Character",@"</xm>"]]);
    for (NSString *state in @[@"RCDATA state",@"RAWTEXT state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"</xm>" state:StateNamed(state)];
        [tokenizer setLastStartTag:@"xmp"];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"bad endtag in RCDATA and RAWTEXT");
    }
}
        
- (void)test9
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"Character",@"</xm "]]);
    for (NSString *state in @[@"RCDATA state",@"RAWTEXT state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"</xm " state:StateNamed(state)];
        [tokenizer setLastStartTag:@"xmp"];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"bad endtag in RCDATA and RAWTEXT");
    }
}
        
- (void)test10
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"Character",@"</xm/"]]);
    for (NSString *state in @[@"RCDATA state",@"RAWTEXT state"]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"</xm/" state:StateNamed(state)];
        [tokenizer setLastStartTag:@"xmp"];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"bad endtag in RCDATA and RAWTEXT");
    }
}
        
- (void)test11
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@[@"StartTag",@"p",@{@"id":@"≂̸"}]]);
    for (NSString *state in @[@""]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"<p id=\"&NotEqualTilde;\">" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"Non BMP-charref in attribute");
    }
}
        
- (void)test12
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@"ParseError",@[@"Comment",@"--!\\U0000FFFD"]]);
    for (NSString *state in @[@""]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"<!----!\\x00-->" state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"--!NUL in comment ");
    }
}
        
- (void)test13
{
    NSArray *expectedTokens = ReifiedTokensForTestTokens(@[@"ParseError",@[@"DOCTYPE",@"html",[NSNull null],[NSNull null],@NO]]);
    for (NSString *state in @[@""]) {
        HTMLTokenizer *tokenizer = [[HTMLTokenizer alloc] initWithString:@"<!DOCTYPE html " state:StateNamed(state)];
        STAssertEqualObjects(tokenizer.allObjects, expectedTokens, @"%@", @"space EOF after doctype ");
    }
}

@end
