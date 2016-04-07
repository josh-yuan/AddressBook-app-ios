//
//  StudentInfoCell.h
//  DREKTORE
//
//  Created by Joshua on 4/6/16.
//  Copyright © 2016 Joshua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *studentPhoto;
@property (weak, nonatomic) IBOutlet UILabel *studentName;
@property (weak, nonatomic) IBOutlet UILabel *studentEmail;
@property (weak, nonatomic) IBOutlet UILabel *studentPhone;

@end
