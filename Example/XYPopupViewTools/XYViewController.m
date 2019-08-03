//
//  XYViewController.m
//  XYPopupViewTools
//
//  Created by 9527xiaoyu on 08/03/2019.
//  Copyright (c) 2019 9527xiaoyu. All rights reserved.
//

#import "XYViewController.h"
#import "Classes/XYPopupViewTools.h"

@interface XYViewController ()
@property (nonatomic, strong)UIView *targetView;
@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)topAction:(UIButton *)sender {
    [XYPopupViewTools popupTopWithTargetView:self.targetView maskClick:YES maskAlpha:0.3];
}

- (IBAction)cTAction:(UIButton *)sender {
    [XYPopupViewTools popupCenterWithFrom:self.view targetView:self.targetView maskAlpha:0.8 showAnima:XYAnimationStyleTop hideAnima:XYAnimationStyleTop maskClick:YES];
}

- (IBAction)cCAction:(id)sender {
    [XYPopupViewTools popupCenterWithFrom:self.view targetView:self.targetView maskAlpha:0.8 showAnima:XYAnimationStyleCenter hideAnima:XYAnimationStyleCenter maskClick:YES];
}

- (IBAction)cBAction:(id)sender {
    [XYPopupViewTools popupCenterWithFrom:self.view targetView:self.targetView maskAlpha:0.8 showAnima:XYAnimationStyleBottom hideAnima:XYAnimationStyleBottom maskClick:YES];
}

- (IBAction)bottomAction:(id)sender {
    [XYPopupViewTools popupBottomWithTargetView:self.targetView maskClick:YES maskAlpha:1];
}

- (UIView *)targetView
{
    if (!_targetView) {
        _targetView = [[UIView alloc]init];
        _targetView.backgroundColor = [UIColor greenColor];
        _targetView.size = CGSizeMake(150, 150);
    }
    return _targetView;
}

@end
