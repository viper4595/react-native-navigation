#import "RNNSideMenuChildVC.h"
#import "UIViewController+LayoutProtocol.h"
@interface RNNSideMenuChildVC ()

@property (readwrite) RNNSideMenuChildType type;
@property (nonatomic, retain) UIViewController<RNNLayoutProtocol> *child;

@end

@implementation RNNSideMenuChildVC


- (instancetype)initWithLayoutInfo:(RNNLayoutInfo *)layoutInfo creator:(id<RNNComponentViewCreator>)creator options:(RNNNavigationOptions *)options defaultOptions:(RNNNavigationOptions *)defaultOptions presenter:(RNNBasePresenter *)presenter eventEmitter:(RNNEventEmitter *)eventEmitter childViewController:(UIViewController *)childViewController type:(RNNSideMenuChildType)type {
	self = [super initWithLayoutInfo:layoutInfo creator:creator options:options defaultOptions:defaultOptions presenter:presenter eventEmitter:eventEmitter childViewControllers:nil];
	self.type = type;
	self.child = childViewController;
	return self;
}

- (void)render {
    [self addChildViewController:self.child];
    [self.child.view setFrame:self.view.bounds];
    [self.view addSubview:self.child.view];
    [self.view bringSubviewToFront:self.child.view];
    [self.child render];
}

- (void)setChild:(UIViewController<RNNLayoutProtocol> *)child {
	_child = child;
}

- (void)setWidth:(CGFloat)width {
	CGRect frame = self.child.view.frame;
	frame.size.width = width;
	self.child.view.frame = frame;
}

- (UIViewController *)getCurrentChild {
	return self.child;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return [[self presenter] getStatusBarStyle:[self resolveOptions]];
}

@end
