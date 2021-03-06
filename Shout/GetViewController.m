//
//  GetViewController.m
//  Shout
//
//  Created by zhousl on 14-9-13.
//  Copyright (c) 2014年 wisorg. All rights reserved.
//

#import "GetViewController.h"
#import "MainViewController.h"
#import "PayofManager.h"

@interface GetViewController ()
{
    IBOutlet UITableView* tabMenu;
    IBOutlet UIView* viewTop;
    
    IBOutlet UILabel* labTip;
    
    IBOutlet UIView* viewBuy;
    IBOutlet UIView* viewSign;
}
@end

@implementation GetViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBuy:)];
    [viewBuy addGestureRecognizer:tap];
    SAFERELEASE(tap);
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSign:)];
    [viewSign addGestureRecognizer:tap];
    SAFERELEASE(tap);
}

// 此方法为生成订单方法  内部可自行实现
- (NSString *)generateTradeNO
{
	const int N = 15;
	
	NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *result = [[NSMutableString alloc] init] ;
	srand(time(0));
	for (int i = 0; i < N; i++)
	{
		unsigned index = rand() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}

-(void)clickBuy:(UITapGestureRecognizer*)sender{
    /*
     测试代码
     */
    
    modelProduct *product = [[modelProduct alloc] init];
    product.subject = @"话费充值";
    product.number = 1;
    product.body = @"[四钻信誉]北京移动30元 电脑全自动充值 1到10分钟内到账";
    product.price = 0.01;
    
    NSString *appScheme = @"Shout_AliPay_Schemes";
    [[PayofManager sharedInstance] MMUniPay:product
                                      order:[self generateTradeNO]
                                      AppID:@""
                                     AppKey:@""
                                    AppName:@"shout"
                                  AndScheme:appScheme
                               withDelegate:nil];
    // end
}

-(void)clickSign:(UITapGestureRecognizer*)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-- UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"newsListCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.backgroundColor = [UIColor colorWithRed:225/255 green:230/255 blue:231/255 alpha:1.0];
        
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    NSArray* arySubviews = cell.contentView.subviews;
    for (UIView* view in arySubviews) {
        [view removeFromSuperview];
    }
    CGRect rect = CGRectMake(15,
                             18,
                             34,
                             34);
    
    UIImageView* ivThumbnail = [[UIImageView alloc] initWithFrame:rect];
    [ivThumbnail setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:ivThumbnail];
    
    rect = CGRectMake(30+34,
                      25,
                      200,
                      20);
    UILabel* labTitle = [[UILabel alloc] initWithFrame:rect];
    labTitle.backgroundColor = [UIColor clearColor];
    labTitle.textAlignment = NSTextAlignmentLeft;
    labTitle.textColor = [UIColor blackColor];
    labTitle.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:labTitle];
    
    rect = CGRectMake(0,
                      68,
                      tableView.frame.size.width,
                      2);
    UIImageView* ivBottomLine = [[UIImageView alloc] initWithFrame:rect];
    [ivBottomLine setBackgroundColor:[UIColor colorWithRed:156/255.0 green:155/255.0 blue:155/255.0 alpha:1]];
    [cell.contentView addSubview:ivBottomLine];
    
    rect = CGRectMake(30+34+215,
                             27,
                             8,
                             16);
    
    switch (indexPath.row) {
        case 0:
        {
            ivThumbnail.image = [UIImage imageNamed:@"sentenceIcon"];
            labTitle.text = @"一句话累计告诉TA 5次送一片";
            
            
            
            UIImageView* ivArrow = [[UIImageView alloc] initWithFrame:rect];
            ivArrow.image = [UIImage imageNamed:@"arrow"];
            [cell.contentView addSubview:ivArrow];
            break;
        }
        case 1:
        {
            ivThumbnail.image = [UIImage imageNamed:@"shoutIcon"];
            labTitle.text = @"大声喊后看排名有惊喜";
            
            UIImageView* ivArrow = [[UIImageView alloc] initWithFrame:rect];
            ivArrow.image = [UIImage imageNamed:@"arrow"];
            [cell.contentView addSubview:ivArrow];
            break;
        }
        case 2:
        {
            ivThumbnail.image = [UIImage imageNamed:@"signIcon"];
            labTitle.text = @"签到连续10天送一片";
            break;
        }
        case 3:
        {
            ivThumbnail.image = [UIImage imageNamed:@"freeIcon"];
            labTitle.text = @"每月免费赠送两片";
            break;
        }
        default:
            break;
    }
    return cell;
}

#pragma mark-- UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (4 <= indexPath.row) {
        return;
    }
    MainViewController* mc = [[self.navigationController viewControllers] objectAtIndex:0];
    
    if (0 == indexPath.row) {
        if ([mc isKindOfClass:[MainViewController class]]) {
            mc.showView = view_OneSentence;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ( 1 == indexPath.row){
        if ([mc isKindOfClass:[MainViewController class]]) {
            mc.showView = view_Shout;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
