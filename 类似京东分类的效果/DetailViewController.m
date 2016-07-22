//
//  DetailViewController.m
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/22.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%100 + 200)/365.0 green:(arc4random()%100 + 200)/365.0 blue:(arc4random()%100 + 200)/365.0 alpha:1.0];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 150, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"click to back" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}
- (void)btnclick:(UIButton *)btn{
    
    if (self.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (self.tag == 2){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (self.Sucess_back) {
        self.Sucess_back(@"nick");
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
