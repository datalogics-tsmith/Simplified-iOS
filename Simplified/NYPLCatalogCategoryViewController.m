#import "NYPLCatalogCategory.h"

#import "NYPLCatalogCategoryViewController.h"

@interface NYPLCatalogCategoryViewController ()

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) NYPLCatalogCategory *category;
@property (nonatomic) NSURL *url;

@end

@implementation NYPLCatalogCategoryViewController

- (instancetype)initWithURL:(NSURL *const)url title:(NSString *const)title
{
  self = [super init];
  if(!self) return nil;
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.url = url;
  self.title = title;
  
  return self;
}

#pragma mark UIViewController

- (void)viewDidLoad
{
  self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  self.activityIndicatorView.center = self.view.center;
  [self.activityIndicatorView startAnimating];
  [self.view addSubview:self.activityIndicatorView];
  
  [NYPLCatalogCategory
   withURL:self.url
   handler:^(NYPLCatalogCategory *const category) {
     [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       self.category = category;
     }];
   }];
}

@end
