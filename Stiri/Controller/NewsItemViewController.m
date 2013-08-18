//
//  NewsItemViewController.m
//  Stiri
//
//  Created by Vlad Stoica on 8/14/13.
//  Copyright (c) 2013 Stoica Vlad. All rights reserved.
//

#import "NewsItemViewController.h"
#import "NewsSource.h"
#import "NewsDataSource.h"
@interface NewsItemViewController ()
@property (nonatomic) BOOL isInOptimalMode;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *titleView;
@property (readonly, nonatomic) NewsItem *currentNewsItem;
@property (readonly, nonatomic) NewsSource *newsSource;
@end

@implementation NewsItemViewController

- (NewsItem *) currentNewsItem{
    return [[NewsDataSource newsDataSource] getNewsItemWithUrl:self.currentNewsItemUrl fromSourceWithId:self.sourceId];
}

- (NSString *) stylePaperize {
    NSString *beg = @"<body style=\"font-family:Helvetica\" >";
    NSString *title = [NSString stringWithFormat:@"<div style=\"font-size:21px;font-weight:bold; \">%@</br></br></div><div align=\"justify\">",self.currentNewsItem.title];
    NSString *end = @"</div></body>";
    NSString *result = [[[beg stringByAppendingString:title] stringByAppendingString:self.currentNewsItem.paperized] stringByAppendingString:end];
    self.isInOptimalMode = YES;
    return result;
}

- (NewsSource*) newsSource{
    return [[NewsDataSource newsDataSource] getNewsSourceWithId:self.sourceId];
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
    self.title = @"News from";
    [self.toolBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    [self.webView loadHTMLString:[self stylePaperize] baseURL:nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareButtonClicked:(id)sender {
    NSArray *activity_elements = @[[NSString stringWithFormat:@"%@ via News from ( available for iOS, Android and WP8 ) ", self.currentNewsItem.url ]];
    UIActivityViewController *uiActivityViewController = [[UIActivityViewController alloc] initWithActivityItems:activity_elements applicationActivities:nil];
    [self presentViewController:uiActivityViewController animated:YES completion:nil];
}
- (IBAction)browserButtonClicked:(id)sender {
    UIBarButtonItem *button = sender;
    if(self.isInOptimalMode == YES) {
        button.title = @"Optimal";
        NSURL *url = [NSURL URLWithString:self.currentNewsItem.url];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        self.isInOptimalMode = NO;
    } else {
        button.title = @"Standard";
        [self.webView loadHTMLString:[self stylePaperize] baseURL:nil];
    }

}

@end
