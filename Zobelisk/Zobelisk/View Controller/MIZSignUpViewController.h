//
//  MIZSignUpViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZSignUpViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

- (IBAction)passFieldDidChange:(id)sender;


@end
