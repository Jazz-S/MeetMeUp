//
//  ViewController.m
//  MeetMeUp
//
//  Created by Jazz Santiago on 3/23/15.
//  Copyright (c) 2015 Orginization. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableDictionary *meetUpDictionary;
@property NSMutableArray *tableViewArray;

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {


        self.meetUpDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        self.tableViewArray = [self.meetUpDictionary objectForKey:@"results"];
        //Make sure view loads with new data from dictionary/array
        [self.tableView reloadData];
    }];


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *dictionary = [self.tableViewArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionary objectForKey:@"name"];
    NSDictionary *addressDictionary = [dictionary objectForKey:@"venue"];
    cell.detailTextLabel.text = [addressDictionary objectForKey:@"address_1"];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArray.count;
}
@end
