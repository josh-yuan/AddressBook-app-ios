//
//  ViewController.h
//  DREKTORE
//
//  Created by Joshua on 4/3/16.
//  Copyright (c) 2016 Joshua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *studentList;
@property (strong, nonatomic) NSString *queryString;
@property (weak, nonatomic) IBOutlet UITableView *studentTable;

@end
