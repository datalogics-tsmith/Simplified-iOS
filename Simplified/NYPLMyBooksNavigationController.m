#import "NYPLMyBooksViewController.h"

#import "NYPLMyBooksNavigationController.h"

@implementation NYPLMyBooksNavigationController

#pragma mark NSObject

- (instancetype)init
{
  self = [super initWithRootViewController:[[NYPLMyBooksViewController alloc] init]];
  if(!self) return nil;
  
  self.tabBarItem.image = [UIImage imageNamed:@"MyBooks"];
  
  return self;
}

@end
