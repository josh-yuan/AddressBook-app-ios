//
//  ViewController.m
//  DREKTORE
//
//  Created by Joshua on 4/3/16.
//  Copyright (c) 2016 Joshua. All rights reserved.
//

#import "SearchViewController.h"
#import "StudentInfoCell.h"
#define studentSearchRootURL @"http://192.168.1.8:8080/v1.0/student/name/"


@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    //self.studentTable.delegate = self;
    //self.studentTable.dataSource = self;
    self.studentTable.estimatedRowHeight = 85.0;
    self.studentTable.rowHeight = UITableViewAutomaticDimension;
    [self.studentTable reloadData];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder];
}

//Search button was tapped
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

//User finished editing the search text
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

//Search on the remote server using HTTP request
- (void)handleSearch:(UISearchBar *)searchBar {
    
    //check what was passed as the query String and get rid of the keyboard
    self.queryString = searchBar.text;
    
    [searchBar resignFirstResponder];
    NSString *studentSearchUrl = [studentSearchRootURL stringByAppendingString:self.queryString];
    //TODO more error handling on user input. + make a seperate utility methods, + unit test it
    //studentSearchUrl = [studentSearchUrl stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"studentSearchUrl is %@", studentSearchUrl);
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:studentSearchUrl] completionHandler:^(NSData * data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error.code == -1009){
            //show error pop up
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlert:@"InternetError"
                    withMessage:@"No_internet_connection"
                 preferredStyle:UIAlertControllerStyleAlert];
            });
        }
        
        NSLog(@"Response data is %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if ([data length] >0 && error == nil){
            [self parseResponse:data];
        }
        else if ([data length] == 0 && error == nil){
            NSLog(@"Empty Response");
        }
        else if (error != nil){
            NSLog(@"The error is= %@", error);
            //should pop up message
        }
        
    }] resume];
}

//parse our JSON response from the server
- (void)parseResponse:(NSData *) data {
    
    NSString *myData = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@", myData);
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:NSJSONReadingAllowFragments
                     error:&error];
    
    if (jsonObject != nil && error == nil){
        NSArray *studentArray = [NSJSONSerialization JSONObjectWithData:[myData dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:0 error:NULL];
        NSLog(@"jsonObject=%@", studentArray);
              self.studentList = [studentArray mutableCopy];
                NSLog(@"total count is %lu", (unsigned long)[self.studentList count]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.studentList count] <= 0){
                [self showAlert:NSLocalizedString(@"No match found", @"comment") withMessage:NSLocalizedString(@"Try another search", @"comment")
                 preferredStyle:UIAlertControllerStyleAlert];
                
            }
            else{
                [self.studentTable reloadData];
                
            }
        });
    }
    else{
        //TODO display error
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.studentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"StudentInfoCell";
    StudentInfoCell *cell = [self.studentTable dequeueReusableCellWithIdentifier:identifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    if(self.studentList.count > 0) {
        NSMutableDictionary *studentInfo = [self.studentList objectAtIndex:indexPath.row];
        cell.studentPhoto.image = [UIImage imageNamed:@"placeholder.png"];
        NSString *fullName = studentInfo[@"firstName"];
        fullName = [fullName stringByAppendingString:@" "];
        fullName = [fullName stringByAppendingString:studentInfo[@"lastName"]];
        cell.studentName.text = fullName;        
        cell.studentEmail.text = studentInfo[@"email"];
        cell.studentPhone.text = studentInfo[@"phone"];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        // loading images asynchronously.
        dispatch_async(queue, ^{
//            NSData *data = [NSData dataWithContentsOfURL : imageURL];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                cell.postImageView.image = [UIImage imageWithData:data];
//                [cell setNeedsLayout];
//            });
        });
    }
    [cell layoutIfNeeded];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(void)showAlert: (NSString *) title withMessage:(NSString*) message preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"comment") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                        {NSLog(@"ok action");}];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
