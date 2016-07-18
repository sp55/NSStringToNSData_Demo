//
//  ViewController.m
//  NSStringToNSData_Demo
//
//  Created by admin on 16/7/18.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

//http://www.jianshu.com/p/26c2deaed138
//iOS的NSString * 与 NSDate *的日期转换处理

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    [self test1];
    [self test2];
    [self test3];
    [self test4];
    
    [self test5];
    
    [self test6];

}

//1.NSString *转 NSDate *
-(void)test1{
    // 时间字符串
    NSString *string = @"2016-7-16 09:33:22";
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSString * -> NSDate *
    NSDate *data = [format dateFromString:string];
    NSString *newString = [format stringFromDate:data];
    NSLog(@"test1-->%@",newString);
}
//方法2.混杂格式
-(void)test2{
    // 时间字符串
    NSString *string = @"7月-16/2016 09:33:22秒";
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"MM月-dd-yyyy HH:mm:ss秒";
    NSLog(@"test2-->%@",[format dateFromString:string]);
    
}
//方法3.国际时间格式
-(void)test3{
    // 时间字符串
    NSString *string = @"Tue May 31 17:46:55 +0800 2016 ";
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"EEE-MMM-dd HH:mm:ss Z yyyy";
    //设置语言区域(因为这种时间是欧美常用时间)
    format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSLog(@"test3-->%@",[format dateFromString:string]);
}
-(void)test4{
    // 时间戳 : 从1970年1月1号 00:00:00开始走过的毫秒数
    NSString *string = @"1287879863267";
    // 获得有多少秒
    NSTimeInterval second = string.longLongValue / 1000.0;
    // 时间戳->NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSLog(@"test4-->%@",date);
}




//1.NSDate *转 NSString *
-(void)test5{
//方法1.datatostring
    NSDate *date1 = [NSDate date];
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    format1.dateFormat = @"yyyy年MM月dd号 HH:mm:ss";
    NSString *string1 = [format1 stringFromDate:date1];
    NSLog(@"test5_1-->%@",string1);
//方法2.获取元素
    NSString *string2 = @"016-07-16 21:16:26";
    NSString *month2 = [string2 substringWithRange:NSMakeRange(4, 5)];
    NSLog(@"test5_2-->%@",month2);
//方法3.利用NSCalendar处理日期获取元素
    NSString *string3 = @"2016-7-16 09:33:22";
    NSDateFormatter *format3 = [[NSDateFormatter alloc] init];
    format3.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *data3 = [format3 dateFromString:string3];
    //利用NSCalendar处理日期
    NSCalendar *calendar3 = [NSCalendar currentCalendar];
    NSInteger mouth3 = [calendar3 component:NSCalendarUnitMonth fromDate:data3];
    NSInteger hour3 = [calendar3 component:NSCalendarUnitHour fromDate:data3];
    NSInteger minute3 = [calendar3 component:NSCalendarUnitMinute fromDate:data3];
    NSInteger second3 = [calendar3 component:NSCalendarUnitSecond fromDate:data3];

    NSLog(@"test5_3-->-%ld月-%ld时-%ld分-%ld秒",mouth3,hour3,minute3,second3);
    
//方法4 获取多位元素
    NSString *string4 = @"2016-7-16 09:33:22";
    NSDateFormatter *format4 = [[NSDateFormatter alloc] init];
    format4.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date4 = [format4 dateFromString:string4];
    //利用NSCalendar处理日期
    NSCalendar *calendar4 = [NSCalendar currentCalendar];
    NSCalendarUnit unit4 = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitSecond|NSCalendarUnitMinute;
    NSDateComponents *comp4 =[calendar4 components:unit4 fromDate:date4];
    NSLog(@"test5_4-->%@",comp4);
    
   
}

//3.时间比较
-(void)test6{
    // 时间字符串
    NSString *createdAtString = @"2016-7-20 11:10:05";
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [format dateFromString:createdAtString];
    // 手机当前时间
    NSDate *nowDate = [NSDate date];
    /**
     NSComparisonResult的取值
     NSOrderedAscending = -1L, // 升序, 越往右边越大
     NSOrderedSame,  // 相等
     NSOrderedDescending // 降序, 越往右边越小
     */
    // 获得比较结果(谁大谁小)
    NSComparisonResult result = [nowDate compare:createdAtDate];
    if (result == NSOrderedAscending) { // 升序, 越往右边越大
        NSLog(@"test6-->createdAtDate > nowDate");
    } else if (result == NSOrderedDescending) { // 降序, 越往右边越小
        NSLog(@"test6-->createdAtDate < nowDate");
    } else {
        NSLog(@"test6-->createdAtDate == nowDate");
    }
    
    
//方法2.时间比较时间相差多少
    NSTimeInterval interval = [createdAtDate timeIntervalSinceNow];
    NSLog(@"test6-->%f",interval);

    
//方法3.时间比较两个时间比较
    // 其他时间
    NSString *otherString =@"2016-7-16 21:53:22";
    NSDate *otherDate = [format dateFromString:otherString];
    // 获得NSCalendar
    NSCalendar *calendar = nil;
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        calendar = [NSCalendar currentCalendar];
    }
    // 获得日期之间的间隔
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:createdAtDate toDate:otherDate options:0];
    NSLog(@"test6-->%@",components);
//方法4.与当前时间比较是否为同一天
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        calendar = [NSCalendar currentCalendar];
    }
    NSDateFormatter *format4 = [[NSDateFormatter alloc] init];
    format4.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSLog(@"test6-->%zd",[calendar isDateInToday:[format4 dateFromString:@"2016-7-16 09:33:22"]]);
 
}
@end
