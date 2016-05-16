//
//  SignUpViewController.m
//  project4
//
//  Created by Yinchuan Zhou on 5/13/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"

@interface SignUpViewController (){
    UIVisualEffectView *blurEffectView;
    NSData *imgData;

}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewOutlet;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lattNameTF;
@property (weak, nonatomic) IBOutlet UITextField *specializationNameTF;
@property (weak, nonatomic) IBOutlet UITextField *qualificationNameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailNameTF;
@property (weak, nonatomic) IBOutlet UITextField *addressNameTF;
@property (weak, nonatomic) IBOutlet UITextField *availableDateNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UIButton *MondayOutlet;
@property (weak, nonatomic) IBOutlet UIButton *TuesdayOutlet;
@property (weak, nonatomic) IBOutlet UIButton *WendsdayOutlet;
@property (weak, nonatomic) IBOutlet UIButton *thursdayOutlet;
@property (weak, nonatomic) IBOutlet UIButton *fridayOutlet;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UIButton *submitOutlet;
@property(strong,nonatomic) NSMutableArray *weekDayArr;
- (IBAction)weekDayBtn_Pressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
- (IBAction)saveBtn_pressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *pickerView;

- (IBAction)SubmitBtn_pressed:(UIButton *)sender;
- (IBAction)imagePickerBtn_pressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImageView;


@property(strong,nonatomic) NSArray *pickerData;
@end

@implementation SignUpViewController
#pragma mark - Textfield Validation
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _firstNameTF) {
        [_lattNameTF becomeFirstResponder];
    }else    if (textField == _lattNameTF) {
        [_passwordTF becomeFirstResponder];
    }else if(textField == _passwordTF){
        [_passwordTF resignFirstResponder];
    }else    if (textField == _specializationNameTF) {
        [_qualificationNameTF becomeFirstResponder];
    }else    if (textField == _qualificationNameTF) {
        [_mobileNameTF becomeFirstResponder];
    }else    if (textField == _mobileNameTF) {
        [_emailNameTF becomeFirstResponder];
    }else    if (textField == _emailNameTF) {
        [_addressNameTF becomeFirstResponder];
    }else    if (textField == _addressNameTF) {
        [_addressNameTF resignFirstResponder];
    }
    if (textField == _availableDateNameTF) {
        [_availableDateNameTF resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
   
    _pickerView.hidden = true;

    if (textField == _firstNameTF) {
        [self checkFirstName:textField]? _firstNameTF.textColor = [UIColor blackColor]:[self shackTheView:textField];
    }else if (textField == _lattNameTF) {
        if ([self checkLastName:textField]) {
            _lattNameTF.textColor = [UIColor blackColor];
            
        }else{
            [self shackTheView:textField];
        }
    }else if (textField == _passwordTF){
        
        if ([self checkPassword:textField]) {
            _passwordTF.textColor = [UIColor blackColor];
            
        }else{
            [self shackTheView:textField];
        }
        
    }else if (textField == _specializationNameTF) {
//        blurEffectView.hidden = true;
        if ([self checkSpecialization:textField]) {
            _specializationNameTF.textColor = [UIColor blackColor];

            
        }else{
            [self shackTheView:textField];
        }
    }else if (textField == _qualificationNameTF) {
//        blurEffectView.hidden = true;
        if ([self checkQualification:textField]) {
            _qualificationNameTF.textColor = [UIColor blackColor];

        }else{
            [self shackTheView:textField];
        }
    }else if (textField == _mobileNameTF) {
        if ([self checkMobile:textField]) {
            _mobileNameTF.textColor = [UIColor blackColor];
        }else{
            [self shackTheView:textField];
        }
    }else    if (textField == _emailNameTF) {
        if ([self checkEmail:textField]) {
            
            _emailNameTF.textColor = [UIColor blackColor];
        }else{
            [self shackTheView:textField];
        }
    
    }else    if (textField == _addressNameTF) {

        if ([self checkAddress:textField]) {
            
            _addressNameTF.textColor = [UIColor blackColor];
        }else{
            [self shackTheView:textField];
        }

    }else    if (textField == _availableDateNameTF) {
//        blurEffectView.hidden = true;
        
        if ([self checkAddress:textField]) {
            
            _availableDateNameTF.textColor = [UIColor blackColor];

        }else{
            [self shackTheView:textField];
        }

    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _specializationNameTF) {
        _specializationNameTF.text = @"Dentist";
        _pickerData = @[@"Dentist",@"Gynecologist",@"Dermatologist",@"Ophthalmologist",@"Psychologist",@"Cardiologist"];
        _pickerView.hidden = false;
        blurEffectView.hidden = false;
        [blurEffectView addSubview:_pickerView];
    }
    
    if (textField == _qualificationNameTF) {
        _qualificationNameTF.text = @"Doctor";
        _pickerData = @[@"Doctor",@"Master",@"Bachelor"];
        _pickerView.hidden = false;
        blurEffectView.hidden = false;
        [blurEffectView addSubview:_pickerView];


    }
    
    if (textField == _availableDateNameTF) {
        _availableDateNameTF.text = @"Morning";
        _pickerData = @[@"Morning",@"Afternoon"];
        _pickerView.hidden = false;
        blurEffectView.hidden = false;
        [blurEffectView addSubview:_pickerView];

    }
    
    [_picker reloadAllComponents];

    
}

#pragma mark - Check Validation Logic

-(void)shackTheView:(UITextField *)textField{
    [UIView animateWithDuration:0.08 animations:^{
         [textField setFrame:CGRectMake(textField.frame.origin.x+15, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            [textField setFrame:CGRectMake(textField.frame.origin.x-25, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.08 animations:^{
                [textField setFrame:CGRectMake(textField.frame.origin.x+10, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)];
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.05 animations:^{
                    [textField setFrame:CGRectMake(textField.frame.origin.x-10, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)];
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.1 animations:^{
                        [textField setFrame:CGRectMake(textField.frame.origin.x+10, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)];
                    }];
                    
                }];
            }];
            
        }];
    }];

}
-(BOOL)checkPassword:(UITextField *)textField{
    int lower = 0;
    int upper = 0;
    int number = 0;
    for (short index=0; index<[textField.text length]; index++) {
        if ([textField.text characterAtIndex:index]>='a'&&[textField.text characterAtIndex:index]<='z') {
            lower++;
        }
        if ([textField.text characterAtIndex:index]>='A'&&[textField.text characterAtIndex:index]<='Z') {
            upper++;
        }
        if ([textField.text characterAtIndex:index]>='0'&&[textField.text characterAtIndex:index]<='9') {
            number++;
        }
    }
    
    if ([textField.text length]>4&&[textField.text length]<9&&lower!=0&&upper!=0&&number!=0) {
        return YES;
    }else{
        return NO;
    }
}
-(BOOL)checkFirstName:(UITextField *)textField{
    
    return [textField.text length];
    
}
-(BOOL)checkLastName:(UITextField *)textField{
    return [textField.text length];;

}
-(BOOL)checkEmail:(UITextField *)textField{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:textField.text];

}
-(BOOL)checkAddress:(UITextField *)textField{
    return [textField.text length];;

}
-(BOOL)checkSpecialization:(UITextField *)textField{
    return [textField.text length];;

}
-(BOOL)checkQualification:(UITextField *)textField{
    return [textField.text length];;

}
-(BOOL)checkAvalibelTime:(UITextField *)textField{
    return [textField.text length];;

}
-(BOOL)checkMobile:(UITextField *)textField{
    return [textField.text length];;

}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

#pragma  mark - textView Setting
- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    [self animatedUP:YES];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self animatedUP:NO];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}





- (void)animatedUP:(BOOL)up{
    const int movementDistance = 150;
    const float movementDuration = 0.3f;
    int movement = (up? -movementDistance: movementDistance);
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2, 80, 80)];
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [self.view addSubview:self.activityIndicatorView];
    
    imgData = UIImagePNGRepresentation(_ProfileImageView.image);
    CGPoint scrollPtUp = CGPointMake(0, 2);
    _ProfileImageView.layer.cornerRadius = _ProfileImageView.layer.frame.size.height/2;
    _ProfileImageView.layer.masksToBounds = YES;
    [_scrollViewOutlet setContentOffset:scrollPtUp animated:YES];
    _pickerView.layer.cornerRadius = 10;
    _pickerView.layer.masksToBounds = YES;
    // Connect data
    _picker.dataSource = self;
    _picker.delegate = self;
    
    self.qualificationNameTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    self.specializationNameTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    self.availableDateNameTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];

    _picker.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    _pickerView.hidden = true;
    
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView];
        blurEffectView.hidden = true;
    }
    else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    _weekDayArr = [[NSMutableArray alloc] init];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
     return _pickerData[row];
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (_pickerData.count == 2) {
        _availableDateNameTF.text = _pickerData[row];
    }else if (_pickerData.count == 3){
        _qualificationNameTF.text = _pickerData[row];
    }else{
        _specializationNameTF.text = _pickerData[row];
    }
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickerData.count;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)weekDayBtn_Pressed:(UIButton *)sender {
    if (sender.tag == 1) {
        _MondayOutlet.selected = !_MondayOutlet.selected;
    }else if(sender.tag == 2){
        _TuesdayOutlet.selected = !_TuesdayOutlet.selected;
    }else if (sender.tag == 3){
        _WendsdayOutlet.selected = !_WendsdayOutlet.selected;
    }else if (sender.tag == 4){
        _thursdayOutlet.selected = !_thursdayOutlet.selected;
    }else if (sender.tag == 5){
        _fridayOutlet.selected = !_fridayOutlet.selected;
    }
}

- (IBAction)saveBtn_pressed:(UIButton *)sender {
    
    [_qualificationNameTF resignFirstResponder];
    [_specializationNameTF resignFirstResponder];
    [_availableDateNameTF resignFirstResponder];
    
    blurEffectView.hidden = true;

}

- (IBAction)SubmitBtn_pressed:(UIButton *)sender {
    [self.activityIndicatorView startAnimating];
    [blurEffectView addSubview:_activityIndicatorView];
    blurEffectView.hidden = false;
    if (_MondayOutlet.selected) {
        [_weekDayArr addObject:@"1"];
    }
    if (_TuesdayOutlet.selected) {
        [_weekDayArr addObject:@"2"];
    }
    if (_WendsdayOutlet.selected) {
        [_weekDayArr addObject:@"3"];
    }
    if (_thursdayOutlet.selected) {
        [_weekDayArr addObject:@"4"];
    }
    if (_fridayOutlet.selected) {
        [_weekDayArr addObject:@"5"];
    }
    
    PFQuery *pwdQuery = [PFQuery queryWithClassName:@"Docotors"];
    [pwdQuery whereKey:@"Mobile" equalTo:_mobileNameTF.text];
    
    [pwdQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        
        if (_firstNameTF.text.length && _lattNameTF.text.length && _emailNameTF.textColor == [UIColor blackColor] && _mobileNameTF.text.length && _specializationNameTF.text.length && _qualificationNameTF.text.length && _addressNameTF.text.length && _passwordTF.textColor == [UIColor blackColor]&& _weekDayArr.count && _availableDateNameTF.text.length) {
            
        
        if (!error) {
            if ([objects count]>0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"password" message:[NSString stringWithFormat:@"Customer is already exsist"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *_Nonnull action) {
                    [self.activityIndicatorView stopAnimating];
                    blurEffectView.hidden = true;
                }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
                
            }else{
                
                PFObject *doctors = [PFObject objectWithClassName:@"Docotors"];
                [doctors setObject:_firstNameTF.text forKey:@"FirstName"];
                [doctors setObject:_lattNameTF.text forKey:@"LastName"];
                [doctors setObject:_passwordTF.text forKey:@"Password"];
                [doctors setObject:_addressNameTF.text forKey:@"Address"];
                [doctors setObject:_mobileNameTF.text forKey:@"Mobile"];
                [doctors setObject:_emailNameTF.text forKey:@"Email"];
                [doctors setObject:_weekDayArr forKey:@"WeekDay"];
                [doctors setObject:_specializationNameTF.text forKey:@"Specialization"];
                [doctors setObject:_qualificationNameTF.text forKey:@"Qualification"];
                [doctors setObject:_availableDateNameTF.text forKey:@"AvailableTime"];
                [doctors setObject:_descriptionText.text forKey:@"Description"];
                
                PFFile *imageFile = [PFFile fileWithData:imgData];
                [doctors setObject:imageFile forKey:@"Image"];
                
                [doctors saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    [self.activityIndicatorView stopAnimating];
                    blurEffectView.hidden = true;
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:_mobileNameTF.text forKey:[NSString stringWithFormat:@"Mobile%@",_mobileNameTF.text]];
                    [defaults setObject:_passwordTF.text forKey:_mobileNameTF.text];
                    [self.navigationController popViewControllerAnimated:YES];
                
                }];
                
            }
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        }
        
        
    }];
}

- (IBAction)imagePickerBtn_pressed:(UIButton *)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    
    imagePicker.allowsEditing=YES;
    
    imagePicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];

}
#pragma mark- image picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString * ,id> *)info{
    UIImage *img = info[UIImagePickerControllerEditedImage];
    _ProfileImageView.image=img;
    imgData = UIImagePNGRepresentation(_ProfileImageView.image);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
