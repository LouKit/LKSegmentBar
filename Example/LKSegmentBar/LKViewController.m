//
//  LKViewController.m
//  LKSegmentBar
//
//  Created by hlrwlbz123@sina.com on 03/20/2017.
//  Copyright (c) 2017 hlrwlbz123@sina.com. All rights reserved.
//

#import "LKViewController.h"
#import "NormalViewController.h"
#import "NavBarViewController.h"
#import "CustomViewController.h"

@interface LKViewController ()

@end

@implementation LKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        [self.navigationController pushViewController:[[NormalViewController alloc]init] animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:[[NavBarViewController alloc]init] animated:YES];
    }else if (indexPath.row == 2){
        [self.navigationController pushViewController:[[CustomViewController alloc]init] animated:YES];
    }
}
@end
