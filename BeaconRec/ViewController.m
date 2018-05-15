//
//  ViewController.m
//  BeaconRec
//
//  Created by Saju Sathyan on 16/01/2018.
//  Copyright © 2018 Sensus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize location manager and set ourselves as the delegate
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"2EB654DB-3574-475E-ACB9-3C517ED4DE7F"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID: uuid major: 1 minor: 1 identifier: @"dk.sensus.iball"];//dk.sensus.BeaconTx
    
    [self.locationManager requestAlwaysAuthorization];
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startRangingBeaconsInRegion: self.myBeaconRegion];  // Ranging for beacons . Enter Region and Exit Region to stop it
    [self.locationManager startMonitoringForRegion: self.myBeaconRegion];
}

-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [self.locationManager startRangingBeaconsInRegion: self.myBeaconRegion];
    NSLog(@"%@", region);
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody =@"Welcome to Sensus ApS";
    notification.soundName = @"Default";
    [[UIApplication sharedApplication] presentLocalNotificationNow: notification];
}

-(void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self.locationManager stopRangingBeaconsInRegion: self.myBeaconRegion];
    NSLog(@"%@", region);
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody =@"Thanks for visiting Sensus ApS. See you again.";
    notification.soundName = @"Default";
    [[UIApplication sharedApplication] presentLocalNotificationNow: notification];
}

-(void) locationManager:(CLLocationManager *)manager didRangeBeacons: (NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if(beacons.count > 0)
    {
        CLBeacon *beacon = beacons[0];
        self.statusLabel.text = [self nameForProximity: beacon.proximity];
    }
    NSLog(@"%@", region);
}

-(NSString *) nameForProximity: (CLProximity) proximity
{
    switch (proximity)
    {
        case CLProximityUnknown:
            self.view.backgroundColor = [UIColor blueColor];
            return @"Unknown";
            break;
        case CLProximityImmediate:
            self.view.backgroundColor = [UIColor greenColor];
            return @"Immediate";
            break;
        case CLProximityNear:
            self.view.backgroundColor = [UIColor yellowColor];
            return @"Near";
            break;
        case CLProximityFar:
            self.view.backgroundColor = [UIColor redColor];
            return @"Far";
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
