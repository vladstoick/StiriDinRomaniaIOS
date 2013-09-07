//
//  AddNewsSourceSearchViewController.m
//  Stiri
//
//  Created by Vlad Stoica on 9/7/13.
//  Copyright (c) 2013 Stoica Vlad. All rights reserved.
//

#import "AddNewsSourceSearchViewController.h"
#import "NewsDataSource.h"
#import "AddNewsSourceSelectGroupViewController.h"
@interface AddNewsSourceSearchViewController ()
@property (strong, nonatomic) NSArray *allFeeds;
@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation AddNewsSourceSearchViewController
- (NSArray*) allFeeds{
    if(!_allFeeds){
        NSMutableArray *allFeeds = [[NSMutableArray alloc] init];
        NSDictionary *categories = [[NewsDataSource newsDataSource]allFeeds];
        for(NSString* category in [categories allKeys]){
            [allFeeds addObjectsFromArray:[categories objectForKey:category]];
        }
        [allFeeds sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSNumber *num1 = [obj1 valueForKey:@"subscribers"];
            NSNumber *num2 = [obj2 valueForKey:@"subscribers"];
            return [num2 compare:num1];
        }];
        self.allFeeds = allFeeds;
    }
    return _allFeeds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//SEARCH

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    searchString = [searchString lowercaseString];
    for(NSDictionary *feed in self.allFeeds){
        NSString *title = [[feed valueForKey:@"title"] lowercaseString];
        if ([title rangeOfString:searchString].location != NSNotFound) {
            [results addObject:feed];
        } 
    }
    self.searchResults = results;
    return YES;
}


//TABLE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tableView){
        return self.allFeeds.count;
    }
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"searchFeedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *feed;
    if(tableView == self.tableView){
        feed = [self.allFeeds objectAtIndex:indexPath.row];
    } else {
        feed = [self.searchResults objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [feed objectForKey:@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[feed objectForKey:@"subscribers"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)cancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
