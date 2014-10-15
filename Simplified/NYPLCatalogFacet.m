#import "NYPLOPDS.h"

#import "NYPLCatalogFacet.h"

@interface NYPLCatalogFacet ()

@property (nonatomic) BOOL active;
@property (nonatomic) NSURL *href;
@property (nonatomic) NSString *title;

@end

@implementation NYPLCatalogFacet

+ (NYPLCatalogFacet *)catalogFacetWithLink:(NYPLOPDSLink *const)link
{
  if(![link.rel isEqualToString:NYPLOPDSRelationFacet]) {
    NYPLLOG(@"Failing to construct facet with incorrect relation.");
    return nil;
  }
  
  BOOL active = NO;
  NSString *group = nil;
  
  for(NSString *const key in link.attributes) {
    if(NYPLOPDSAttributeKeyStringIsActiveFacet(key)) {
      active = [link.attributes[key] rangeOfString:@"true"
                                           options:NSCaseInsensitiveSearch].location != NSNotFound;
      continue;
    }
    if(NYPLOPDSAttributeKeyStringIsFacetGroup(key)) {
      group = link.attributes[key];
      continue;
    }
  }

  return [[self alloc] initWithActive:active href:link.href title:link.title];
}

- (instancetype)initWithActive:(BOOL const)active
                          href:(NSURL *const)href
                         title:(NSString *const)title
{
  self = [super init];
  if(!self) return nil;
  
  self.active = active;
  
  if(!href) {
    @throw NSInvalidArgumentException;
  }
  
  self.href = href;
  
  self.title = title;
  
  return self;
}

@end
