#import "NYPLConfiguration.h"

#import "NYPLReaderSettingsView.h"

@interface NYPLReaderSettingsView ()

@property (nonatomic) UIButton *blackOnSepiaButton;
@property (nonatomic) UIButton *blackOnWhiteButton;
@property (nonatomic) UIImageView *brightnessHighImageView;
@property (nonatomic) UIImageView *brightnessLowImageView;
@property (nonatomic) UISlider *brightnessSlider;
@property (nonatomic) UIView *brightnessView;
@property (nonatomic) UIButton *decreaseButton;
@property (nonatomic) UIButton *increaseButton;
@property (nonatomic) UIButton *sansButton;
@property (nonatomic) UIButton *serifButton;
@property (nonatomic) UIButton *whiteOnBlackButton;

@end

@implementation NYPLReaderSettingsView

#pragma mark NSObject

- (instancetype)init
{
  self = [super init];
  if (!self) return nil;

  self.backgroundColor = [NYPLConfiguration backgroundColor];

  [self sizeToFit];

  self.sansButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.sansButton.backgroundColor = [NYPLConfiguration backgroundColor];
  [self.sansButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.sansButton setTitle:@"Aa" forState:UIControlStateNormal];
  self.sansButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:24];
  [self.sansButton addTarget:self
                      action:@selector(didSelectSans)
            forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.sansButton];

  self.serifButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.serifButton.backgroundColor = [NYPLConfiguration backgroundColor];
  [self.serifButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.serifButton setTitle:@"Aa" forState:UIControlStateNormal];
  self.serifButton.titleLabel.font = [UIFont fontWithName:@"Georgia" size:24];
  [self.serifButton addTarget:self
                       action:@selector(didSelectSerif)
             forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.serifButton];

  self.whiteOnBlackButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.whiteOnBlackButton.backgroundColor = [NYPLConfiguration backgroundDarkColor];
  [self.whiteOnBlackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.whiteOnBlackButton setTitle:@"ABCabc" forState:UIControlStateNormal];
  self.whiteOnBlackButton.titleLabel.font = [UIFont systemFontOfSize:18];
  [self.whiteOnBlackButton addTarget:self
                              action:@selector(didSelectWhiteOnBlack)
                    forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.whiteOnBlackButton];

  self.blackOnSepiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.blackOnSepiaButton.backgroundColor = [NYPLConfiguration backgroundSepiaColor];
  [self.blackOnSepiaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.blackOnSepiaButton setTitle:@"ABCabc" forState:UIControlStateNormal];
  self.blackOnSepiaButton.titleLabel.font = [UIFont systemFontOfSize:18];
  [self.blackOnSepiaButton addTarget:self
                              action:@selector(didSelectBlackOnSepia)
                    forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.blackOnSepiaButton];

  self.blackOnWhiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.blackOnWhiteButton.backgroundColor = [NYPLConfiguration backgroundColor];
  [self.blackOnWhiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.blackOnWhiteButton setTitle:@"ABCabc" forState:UIControlStateNormal];
  self.blackOnWhiteButton.titleLabel.font = [UIFont systemFontOfSize:18];
  [self.blackOnWhiteButton addTarget:self
                              action:@selector(didSelectBlackOnWhite)
                    forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.blackOnWhiteButton];

  self.decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.decreaseButton.backgroundColor = [NYPLConfiguration backgroundColor];
  [self.decreaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.decreaseButton setTitle:@"A" forState:UIControlStateNormal];
  self.decreaseButton.titleLabel.font = [UIFont systemFontOfSize:14];
  [self.decreaseButton addTarget:self
                          action:@selector(didSelectDecrease)
                forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.decreaseButton];

  self.increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
  self.increaseButton.backgroundColor = [NYPLConfiguration backgroundColor];
  [self.increaseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.increaseButton setTitle:@"A" forState:UIControlStateNormal];
  self.increaseButton.titleLabel.font = [UIFont systemFontOfSize:24];
  [self.increaseButton addTarget:self
                          action:@selector(didSelectIncrease)
                forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.increaseButton];

  self.brightnessView = [[UIView alloc] init];
  [self addSubview:self.brightnessView];
  
  self.brightnessLowImageView = [[UIImageView alloc]
                                 initWithImage:[UIImage imageNamed:@"BrightnessLow"]];
  [self.brightnessView addSubview:self.brightnessLowImageView];
  
  self.brightnessHighImageView = [[UIImageView alloc]
                                  initWithImage:[UIImage imageNamed:@"BrightnessHigh"]];
  [self.brightnessView addSubview:self.brightnessHighImageView];
  
  self.brightnessSlider = [[UISlider alloc] init];
  [self.brightnessSlider addTarget:self
                            action:@selector(didChangeBrightness)
                  forControlEvents:UIControlEventValueChanged];
  [self.brightnessView addSubview:self.brightnessSlider];

  [[NSNotificationCenter defaultCenter]
      addObserverForName:UIScreenBrightnessDidChangeNotification
                  object:nil
                   queue:[NSOperationQueue mainQueue]
              usingBlock:^(NSNotification *const notification) {
                self.brightnessSlider.value = ((UIScreen *) notification.object).brightness;
              }];

  self.brightnessSlider.value = [UIScreen mainScreen].brightness;

  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UIView

- (void)layoutSubviews
{
  CGFloat const padding = 20;
  CGFloat const innerWidth = CGRectGetWidth(self.frame) - padding * 2;

  self.sansButton.frame = CGRectMake(padding,
                                     0,
                                     innerWidth / 2.0,
                                     CGRectGetHeight(self.frame) / 4.0);
  
  self.serifButton.frame = CGRectMake(CGRectGetWidth(self.frame) / 2.0,
                                      0,
                                      innerWidth / 2.0,
                                      CGRectGetHeight(self.frame) / 4.0);
  
  self.whiteOnBlackButton.frame = CGRectMake(padding,
                                             CGRectGetMaxY(self.serifButton.frame),
                                             round(innerWidth / 3.0),
                                             CGRectGetHeight(self.frame) / 4.0);
  
  self.blackOnSepiaButton.frame = CGRectMake(CGRectGetMaxX(self.whiteOnBlackButton.frame),
                                             CGRectGetMaxY(self.serifButton.frame),
                                             round(innerWidth / 3.0),
                                             CGRectGetHeight(self.frame) / 4.0);
  
  self.blackOnWhiteButton.frame = CGRectMake(CGRectGetMaxX(self.blackOnSepiaButton.frame),
                                             CGRectGetMaxY(self.serifButton.frame),
                                             (CGRectGetWidth(self.frame) - padding -
                                              CGRectGetMaxX(self.blackOnSepiaButton.frame)),
                                             CGRectGetHeight(self.frame) / 4.0);
  
  self.decreaseButton.frame = CGRectMake(padding,
                                         CGRectGetMaxY(self.whiteOnBlackButton.frame),
                                         innerWidth / 2.0,
                                         CGRectGetHeight(self.frame) / 4.0);
  
  self.increaseButton.frame = CGRectMake(CGRectGetMaxX(self.decreaseButton.frame),
                                         CGRectGetMaxY(self.whiteOnBlackButton.frame),
                                         innerWidth / 2.0,
                                         CGRectGetHeight(self.frame) / 4.0);
  
  self.brightnessView.frame = CGRectMake(padding,
                                         CGRectGetMaxY(self.decreaseButton.frame),
                                         innerWidth,
                                         CGRectGetHeight(self.frame) / 4.0);
  
  self.brightnessLowImageView.frame =
    CGRectMake(padding,
               (CGRectGetHeight(self.brightnessView.frame) / 2 -
                CGRectGetHeight(self.brightnessLowImageView.frame) / 2),
               CGRectGetWidth(self.brightnessLowImageView.frame),
               CGRectGetHeight(self.brightnessLowImageView.frame));
  
  self.brightnessHighImageView.frame =
    CGRectMake((CGRectGetWidth(self.brightnessView.frame) - padding -
                CGRectGetWidth(self.brightnessHighImageView.frame)),
               (CGRectGetHeight(self.brightnessView.frame) / 2 -
                CGRectGetHeight(self.brightnessHighImageView.frame) / 2),
               CGRectGetWidth(self.brightnessHighImageView.frame),
               CGRectGetHeight(self.brightnessHighImageView.frame));
  
  [self.brightnessSlider sizeToFit];
  CGFloat const sliderPadding = 5;
  CGFloat const brightnessSliderWidth =
    ((CGRectGetMinX(self.brightnessHighImageView.frame) -
      CGRectGetWidth(self.brightnessView.frame) / 2)
     * 2
     - sliderPadding * 2);
  
  self.brightnessSlider.frame = CGRectMake((CGRectGetWidth(self.brightnessView.frame) / 2 -
                                            brightnessSliderWidth / 2),
                                           (CGRectGetHeight(self.brightnessView.frame) / 2 -
                                            CGRectGetHeight(self.brightnessSlider.frame) / 2),
                                           brightnessSliderWidth,
                                           CGRectGetHeight(self.brightnessSlider.frame));
}

- (void)drawRect:(__attribute__((unused)) CGRect)rect
{
  [self layoutIfNeeded];

  CGContextRef const c = UIGraphicsGetCurrentContext();
  CGFloat const gray[4] = {0.5, 0.5, 0.5, 1.0};
  CGContextSetStrokeColor(c, gray);

  CGContextBeginPath(c);
  CGContextMoveToPoint(c,
                       CGRectGetMinX(self.whiteOnBlackButton.frame),
                       CGRectGetMinY(self.whiteOnBlackButton.frame));
  CGContextAddLineToPoint(c,
                          CGRectGetMaxX(self.blackOnWhiteButton.frame),
                          CGRectGetMinY(self.blackOnWhiteButton.frame));
  CGContextStrokePath(c);
  
}

- (CGSize)sizeThatFits:(CGSize)size
{
  CGFloat const w = 320;
  CGFloat const h = 200;

  if (CGSizeEqualToSize(size, CGSizeZero)) {
    return CGSizeMake(w, h);
  }

  return CGSizeMake(w > size.width ? size.width : w, h > size.height ? size.height : h);
}

#pragma mark -

- (void)setFontSize:(NYPLReaderSettingsFontSize const)fontSize
{
  _fontSize = fontSize;
  
  switch(fontSize) {
    case NYPLReaderSettingsFontSizeSmallest:
      self.decreaseButton.enabled = NO;
      self.increaseButton.enabled = YES;
      break;
    case NYPLReaderSettingsFontSizeLargest:
      self.decreaseButton.enabled = YES;
      self.increaseButton.enabled = NO;
      break;
    case NYPLReaderSettingsFontSizeSmaller:
      // fallthrough
    case NYPLReaderSettingsFontSizeSmall:
      // fallthrough
    case NYPLReaderSettingsFontSizeNormal:
      // fallthrough
    case NYPLReaderSettingsFontSizeLarge:
      // fallthrough
    case NYPLReaderSettingsFontSizeLarger:
      self.decreaseButton.enabled = YES;
      self.increaseButton.enabled = YES;
      break;
  }
}

- (void)didSelectSans
{
  self.fontType = NYPLReaderSettingsFontTypeSans;

  [self.delegate readerSettingsView:self didSelectFontType:self.fontType];
}

- (void)didSelectSerif
{
  self.fontType = NYPLReaderSettingsFontTypeSerif;

  [self.delegate readerSettingsView:self didSelectFontType:self.fontType];
}

- (void)didChangeBrightness
{
  [self.delegate readerSettingsView:self didSelectBrightness:self.brightnessSlider.value];
}

- (void)didSelectWhiteOnBlack
{
  self.colorScheme = NYPLReaderSettingsColorSchemeWhiteOnBlack;
  
  [self.delegate readerSettingsView:self didSelectColorScheme:self.colorScheme];
}

- (void)didSelectBlackOnWhite
{
  self.colorScheme = NYPLReaderSettingsColorSchemeBlackOnWhite;
  
  [self.delegate readerSettingsView:self didSelectColorScheme:self.colorScheme];
}

- (void)didSelectBlackOnSepia
{
  self.colorScheme = NYPLReaderSettingsColorSchemeBlackOnSepia;
  
  [self.delegate readerSettingsView:self didSelectColorScheme:self.colorScheme];
}

- (void)didSelectDecrease
{
  NYPLReaderSettingsFontSize newFontSize;
  
  if(!NYPLReaderSettingsDecreasedFontSize(self.fontSize, &newFontSize)) {
    NYPLLOG(@"Ignorning attempt to set font size below the minimum.");
    return;
  }
  
  self.fontSize = newFontSize;
  
  [self.delegate readerSettingsView:self didSelectFontSize:self.fontSize];
}

- (void)didSelectIncrease
{
  NYPLReaderSettingsFontSize newFontSize;
  
  if(!NYPLReaderSettingsIncreasedFontSize(self.fontSize, &newFontSize)) {
    NYPLLOG(@"Ignorning attempt to set font size above the maximum.");
    return;
  }
  
  self.fontSize = newFontSize;
  
  [self.delegate readerSettingsView:self didSelectFontSize:self.fontSize];
}

@end
