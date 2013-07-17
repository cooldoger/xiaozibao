//
//  MasterViewController.m
//  MasterDetail
//
//  Created by mac on 13-7-13.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "AFJSONRequestOperation.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController
@synthesize locationManager;
@synthesize searchBar;

- (void)fetchJson:(NSMutableArray*) listObject
              urlStr:(NSString*)urlStr
{
    //NSURL *url = [NSURL URLWithString:@"http://httpbin.org/ip"];

    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [listObject insertObject:[JSON valueForKeyPath:@"content"] atIndex:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", error);
        NSLog(@"%@", urlStr);
        NSLog(@"error");
    }];
    
    [operation start];
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Creative Ideas";
    
    UIBarButtonItem *hideButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideArticle:)];    
    self.navigationItem.leftBarButtonItem = hideButton;

    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(settingArticle:)];
    self.navigationItem.rightBarButtonItem = settingButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    _objects = [[NSMutableArray alloc] init];

    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=807c44f8b4e0220347ce77cb4743c5a2"];
    
    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=3aaae1a35a73722372e1b49343c2c3dc"];
    
    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=10e49b2ec7d1c681798258b736426a04"];
    
    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=ad65676e3fc3266dfa40044656ce4fe0"];
    
    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=2399537bd81f5bf3a1e42c8ce7e99d73"];    

    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=3bd6fafe612ddfdcf37b4046a2540130"];    

    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=bc30c50697ee1c394b9395383b527bc5"];
    
    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=b5516af3b90d6e0256d48655b0cdfc74"];

    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=773ee95b47cd8c50119078d5f5b4fc2a"];    

    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=d2a28a975f870ffe15327d48bc458fc1"];    

    [self fetchJson:_objects urlStr:@"http://173.255.227.47:9080/api_get_post?id=de8857f350191c79bcc5791ff4248c57"];    

    [self initLocationManager];
    
}

- (void) initLocationManager
{
    /*
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
     */
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                     degrees, minutes, seconds];
    NSLog(@" Current Latitude : %@",lat);
    //latLabel.text = lat;
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                       degrees, minutes, seconds];
    NSLog(@" Current Longitude : %@",longt);
    //longLabel.text = longt;

    searchBar.text = [@"经度: " stringByAppendingString:longt];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideArticle:(id)sender
{
        //NSBundle
   // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
  //  NSArray *arr = [NSArray arrayWithObject:indexPath];
//    [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];

    
    //NSArray* arr = [NSArray arrayWithObject:self.tableView.indexPathForSelectedRow];
    //[self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
/*
    for (int i=0; i<_objects.count; i++) {
        cell = [self.tableView deleteRowsAtIndexPaths];
        cell.textLabel.textColor = [UIColor grayColor];
    }
 */
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"statedictionary" ofType:@"plist"];

    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSLog(@"%@", dict);

    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [locationManager startUpdatingLocation];
    NSLog(@"%1f", locationManager.location.coordinate.longitude);
    
}

- (void)settingArticle:(id)sender
{

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *data = _objects[indexPath.row];

        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor grayColor];
        
        //NSLog(@"%@", data);
        [[segue destinationViewController] setDetailItem:data];
    }
}

@end
