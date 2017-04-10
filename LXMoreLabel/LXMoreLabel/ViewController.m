//
//  ViewController.m
//  LXMoreLabel
//
//  Created by 盼 on 2017/3/16.
//  Copyright © 2017年 pan. All rights reserved.
//

#import "ViewController.h"

#define SLFontSize 14
#define lineSpace  5
#define kAUTOLAYOUTSACLE (kSCREEN_WIDTH/375.0)
#define KSCOLLING (kSCREEN_WIDTH/320)
#define kIPhone6Scale(x) (x * kAUTOLAYOUTSACLE)
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

NSString * str = @"别丢掉 这一把过往的热情，现在流水似的，轻轻 在幽冷的山泉底，在黑夜，在松林，叹息似的渺茫，你仍要保存着那真！一样是明月，一样是隔山灯火，满天的星，只有人不见，梦似的挂起，你向黑夜要回 那一句话--你仍得相信 山谷中留着 有那回音！";

@interface ViewController ()
/**  */
@property (nonatomic,strong) UILabel * label;
/**  */
@property (nonatomic,strong) UIButton * moreButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(kIPhone6Scale(16), 100, kSCREEN_WIDTH - kIPhone6Scale(32), 0)];
    _label.numberOfLines = 0;
    _label.backgroundColor = [UIColor greenColor];
    _label.textColor = [UIColor blackColor];
    [self.view addSubview:_label];
    
    UIFont * font = [UIFont systemFontOfSize:SLFontSize];
    
    //获取文字内容的高度
    CGFloat textHeight = [self boundingRectWithWidth:kSCREEN_WIDTH - kIPhone6Scale(32) withTextFont:font withLineSpacing:lineSpace text:str].height;

    //文字高度超过三行，截取三行的高度，否则有多少显示多少
    if (textHeight > font.lineHeight*3+2*lineSpace) {
        textHeight = font.lineHeight*3+2*lineSpace;
    }
    
    //设置label的富文本
    _label.attributedText = [self attributedStringFromStingWithFont:font withLineSpacing:lineSpace text:str];
    
    _label.frame = CGRectMake(kIPhone6Scale(16), 100,kSCREEN_WIDTH - kIPhone6Scale(32) ,textHeight);
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.frame = CGRectMake(30, CGRectGetMaxY(_label.frame) + 20, 44, 44);
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(showAll) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:_moreButton];
}

- (void)showAll
{
    UIFont * font = [UIFont systemFontOfSize:SLFontSize];
    if ([_moreButton.titleLabel.text  isEqualToString:@"全文"]) {
        [_label sizeToFit];
        [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
    }else
    {
        _label.frame = CGRectMake(kIPhone6Scale(16), 100,kSCREEN_WIDTH - kIPhone6Scale(32),font.lineHeight*3+2*lineSpace);
        [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    }
    _moreButton.frame = CGRectMake(30, CGRectGetMaxY(_label.frame) + 20, 44, 44);
}

/**
 *  根据文字内容动态计算UILabel宽高
 *  @param maxWidth label宽度
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
-(CGSize)boundingRectWithWidth:(CGFloat)maxWidth
                   withTextFont:(UIFont *)font
                withLineSpacing:(CGFloat)lineSpacing
                           text:(NSString *)text{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    //段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle setLineSpacing:lineSpacing];
//#warning 此处设置NSLineBreakByTruncatingTail会导致计算文字高度方法失效
//    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    //计算文字尺寸
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return size;
}

/**
 *  NSString转换成NSMutableAttributedString
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
                                                           text:(NSString *)text{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail]; //截断方式，"abcd..."
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [text length])];
    return attributedStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
