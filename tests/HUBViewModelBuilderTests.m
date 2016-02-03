#import <XCTest/XCTest.h>

#import "HUBViewModelBuilderImplementation.h"
#import "HUBViewModelImplementation.h"
#import "HUBComponentModelBuilder.h"

@interface HUBViewModelBuilderTests : XCTestCase

@end

@implementation HUBViewModelBuilderTests

- (void)testPropertyAssignment
{
    NSString * const featureIdentifier = @"feature";
    
    HUBViewModelBuilderImplementation * const builder = [[HUBViewModelBuilderImplementation alloc] initWithFeatureIdentifier:featureIdentifier];
    
    XCTAssertNotNil(builder.viewIdentifier);
    XCTAssertEqualObjects(builder.featureIdentifier, featureIdentifier);
    
    builder.viewIdentifier = @"view";
    builder.featureIdentifier = @"another feature";
    builder.entityIdentifier = @"entity";
    builder.navigationBarTitle = @"nav title";
    builder.extensionURL = [NSURL URLWithString:@"www.spotify.com"];
    builder.customData = @{@"custom": @"data"};
    
    HUBViewModelImplementation * const model = [builder build];
    
    XCTAssertEqualObjects(model.identifier, builder.viewIdentifier);
    XCTAssertEqualObjects(model.featureIdentifier, builder.featureIdentifier);
    XCTAssertEqualObjects(model.entityIdentifier, builder.entityIdentifier);
    XCTAssertEqualObjects(model.navigationBarTitle, builder.navigationBarTitle);
    XCTAssertEqualObjects(model.extensionURL, builder.extensionURL);
    XCTAssertEqualObjects(model.customData, builder.customData);
}

- (void)testHeaderComponentBuilder
{
    HUBViewModelBuilderImplementation * const builder = [[HUBViewModelBuilderImplementation alloc] initWithFeatureIdentifier:@"feature"];
    XCTAssertEqualObjects(builder.headerComponentModelBuilder.modelIdentifier, @"header");
    XCTAssertNil(builder.headerComponentModelBuilder.componentIdentifier);
}

- (void)testBodyComponentBuilders
{
    NSString * const componentModelIdentifier = @"identifier";
    
    HUBViewModelBuilderImplementation * const builder = [[HUBViewModelBuilderImplementation alloc] initWithFeatureIdentifier:@"feature"];
    
    XCTAssertFalse([builder builderExistsForBodyComponentModelWithIdentifier:componentModelIdentifier]);
    
    id<HUBComponentModelBuilder> const componentBuilder = [builder builderForBodyComponentModelWithIdentifier:componentModelIdentifier];
    
    XCTAssertNotNil(componentBuilder);
    XCTAssertTrue([builder builderExistsForBodyComponentModelWithIdentifier:componentModelIdentifier]);
    XCTAssertEqual(componentBuilder,  [builder builderForBodyComponentModelWithIdentifier:componentModelIdentifier]);
}

- (void)testFeatureIdentifierMatchingComponentTargetInitialViewModelFeatureIdentifier
{
    HUBViewModelBuilderImplementation * const builder = [[HUBViewModelBuilderImplementation alloc] initWithFeatureIdentifier:@"feature"];
    XCTAssertEqualObjects(builder.headerComponentModelBuilder.targetInitialViewModelBuilder.featureIdentifier, builder.featureIdentifier);
}

@end