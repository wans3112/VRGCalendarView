//
//  VRGViewController.m
//  Vurig Calendar
//
//  Created by in 't Veen Tjeerd on 5/29/12.
//  Copyright (c) 2012 Vurig. All rights reserved.
//

#import "VRGViewController.h"



@interface VRGViewController ()

@end

@implementation VRGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
 
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
    {
        VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
        //    calendar.frame=CGRectMake(0, 100, 320, 300);
        calendar.delegate=self;
        UIScrollView *view=[[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 291)]autorelease];
        [view setContentSize:CGSizeMake(320, 337)];
        view.userInteractionEnabled=YES;
        [view addSubview:calendar];
        self.editText.inputView=view;
    }else{
        UIDatePicker *datePicker = [[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 320, 216)]autorelease];
        // 设置时区
        [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        // 设置当前显示时间
        [datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [datePicker setMaximumDate:[NSDate date]];
        // 设置UIDatePicker的显示模式
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        // 当值发生改变的时候调用的方法
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
//        NSDate* minDate = [[NSDate alloc]initWithString:@"1900-01-01 00:00:00 -0500"];
//        NSDate* maxDate = [[NSDate alloc]initWithString:@"2099-01-01 00:00:00 -0500"];
//        
//        datePicker.minimumDate = minDate;
//        datePicker.maximumDate = maxDate;
        self.editText.inputView=datePicker;
    }
  //297,337
    // Keyboard toolbar
    if (self.keyboardToolbar == nil) {
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        self.keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *previousBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"previous", @"")
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(previousField:)];
        
        UIBarButtonItem *nextBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"next", @"")
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(nextField:)];
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"done", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(resignKeyboard:)];
        
        [self.keyboardToolbar setItems:[NSArray arrayWithObjects:previousBarItem, nextBarItem, spaceBarItem, doneBarItem, nil]];
        self.editText.inputAccessoryView=self.keyboardToolbar;
    }
}

- (void)resignKeyboard:(id)sender
{
    
}

- (void)previousField:(id)sender
{
    
}

- (void)nextField:(id)sender
{
    
}

- (void)datePickerValueChanged:(UIDatePicker *)datePicker{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];

    [formatter setDateFormat:@"YYYY-MM-d"];
    
    //时间格式正规化并做时区校正
    NSString *correctDate = [formatter stringFromDate:datePicker.date];
     self.editText.text=correctDate;
}

- (void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSTimeZone *timezone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式
//    [formatter setDateFormat:@"YYYY-MM-d HH:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM-d"];

    //设定时区
    [formatter setTimeZone:timezone];
    
    //时间格式正规化并做时区校正
    NSString *correctDate = [formatter stringFromDate:date];
    
    NSLog(@"地点：%@ 当地时间：%@,calendarView:%f",[timezone name], correctDate,calendarView.frame.size.height);
    self.editText.text=correctDate;
//    NSLog(@"Selected date = %@",date);
    
    UIScrollView *view=(UIScrollView*)self.editText.inputView;
    NSLog(@"UIScrollView:%f",view.contentOffset.y);
    if (calendarView.frame.size.height == 291) {
         view.scrollEnabled=NO;
        [view setContentOffset:CGPointMake(0, 0)];
    }else{
        view.scrollEnabled=YES;
    }
   
}

- (void)viewDidUnload
{
    [self setEditText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_editText release];
    [super dealloc];
}
- (IBAction)beginText:(UITextField *)sender {
    
}
@end
