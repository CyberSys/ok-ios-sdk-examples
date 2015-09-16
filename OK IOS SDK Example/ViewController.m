//
//  ViewController.m
//  OK IOS SDK Example
//
//  Created by Dmitry on 8/24/15.
//  Copyright (c) 2015 ok.ru. All rights reserved.
//

#import "ViewController.h"
#import "OKSDK.h"

@interface ViewController ()

@end

@implementation ViewController

static OKErrorBlock commonError = ^(NSError *error) {
      dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
      });
    
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonDidTouch:(id)sender {
    [OKSDK authorizeWithPermissions:@[@"VALUABLE_ACCESS",@"LONG_ACCESS_TOKEN"] success:^(id data) {
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"authorized"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:controller animated:YES];
        });
        [OKSDK invokeMethod:@"users.getCurrentUser" arguments:@{} success:^(NSDictionary* data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [controller.navigationItem setTitle:[NSString stringWithFormat:@"Hello %@ %@!!!", data[@"first_name"], data[@"last_name"]]];
            });
        } error: commonError];
        
        
    } error:commonError];
}
- (IBAction)sdkInitDidTouch:(id)sender {
    [OKSDK sdkInit:^(id data) {
          dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SDK TOKEN"
                                                        message:data[@"session_key"]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
          });
    } error:commonError];
}
- (IBAction)sdkGetNotesDidTouch:(id)sender {
    [OKSDK invokeSdkMethod:@"sdk.getNotes" arguments:@{} success:^(id data) {
          dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *messages = data[@"notes"];
        NSString *message = [NSString stringWithFormat:@"messages: %lu",[messages count]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"getNotes"
                                                        message: message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
          });
    } error:commonError];
    
}
- (IBAction)clearButtonDidTouch:(id)sender {
    [OKSDK clearAuth];
}
- (IBAction)postMediatopicDidTouch:(id)sender {
    [OKSDK showWidget:@"WidgetMediatopicPost" arguments:@{@"st.attachment":@"{\"media\":[{\"text\":\"\u0411\u0438\u0442\u0432\u0430 \u0437\u0430 \u0422\u0440\u043E\u043D - \u0435\u0449\u0435 \u043E\u0434\u043D\u043E \u0441\u0435\u043A\u0440\u0435\u0442\u043D\u043E\u0435 \u0437\u0430\u0434\u0430\u043D\u0438\u0435 \u0437\u0430\u0432\u0435\u0440\u0448\u0435\u043D\u043E!\",\"type\":\"text\"},{\"text\":\" \",\"images\":[{\"title\":\"\u041E\u0431\u0440\u0435\u0442\u0438 \u0441\u043B\u0430\u0432\u0443 \u0432 \u0441\u0430\u043C\u043E\u0439 \u044D\u043F\u0438\u0447\u0435\u0441\u043A\u043E\u0439 \u0438\u0433\u0440\u0435 \u0432\u0441\u0435\u0445 \u0432\u0440\u0435\u043C\u0435\u043D!\",\"mark\":\"crush_the_castle\",\"url\":\"http://static-epicwar.progrestar.net/odnoklassniki/static_gpu/assets/social/crush_the_castle.jpg\"}],\"type\":\"app\"}]}"} options:@{@"st.utext":@"on"} success:^(NSDictionary *data) {
          dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:[NSString stringWithFormat:@"id: %@",data[@"id"]]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
          });
        
    } error:commonError];

}

- (IBAction)inviteFriendsDidTouch:(id)sender {
    [OKSDK showWidget:@"WidgetInvite" arguments:@{} options:@{} success:^(NSDictionary *data) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:[NSString stringWithFormat:@"invited: %@",data[@"selected"]]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } error:commonError];
}

- (IBAction)suggestFriendsDidTouch:(id)sender {
    [OKSDK showWidget:@"WidgetSuggest" arguments:@{} options:@{} success:^(NSDictionary *data) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:[NSString stringWithFormat:@"suggested: %@",data[@"selected"]]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    } error:commonError];
}

@end
