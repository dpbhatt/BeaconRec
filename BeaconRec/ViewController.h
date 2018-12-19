//
//  ViewController.h
//  BeaconRec
//
//  Created by DP Bhatt on 16/01/2018.
//  Copyright © 2018 AceMySkills. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

