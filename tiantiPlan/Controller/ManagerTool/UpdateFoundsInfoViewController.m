//
//  UpdateFoundsInfoViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/17.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UpdateFoundsInfoViewController.h"
#import "BK_ELCAlbumPickerController.h"
#import "BK_ELCImagePickerController.h"
#import "UIImage+Resize.h"
#import "FilePathManager.h"
#import "FoundsApiManager.h"

@interface UpdateFoundsInfoViewController () <UINavigationBarDelegate, UIImagePickerControllerDelegate,ELCImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *arrayImageUrl;
@property (nonatomic, strong) UIImage *imageIcon;
@property (nonatomic, assign) NSInteger imagecount;

@end

@implementation UpdateFoundsInfoViewController

#pragma mark - lifeCycleMethods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initData {
    self.imagecount = 0;
    self.arrayImageUrl = [NSMutableArray array];
}

- (void)initUI {
    [self setTitle:[NSString stringWithFormat:@"%@", self.foundsModel.name]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 64, 80, 50);
    button.backgroundColor = DSColor;
    [button setTitle:@"修改照片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)selectImage {
    BK_ELCAlbumPickerController *albumPicker = [[BK_ELCAlbumPickerController alloc] initWithStyle:UITableViewStylePlain];
    BK_ELCImagePickerController *elcPicker = [[BK_ELCImagePickerController alloc] initWithRootViewController:albumPicker];
    elcPicker.maximumImagesCount = 10 ; //(maxCount - self.roomImageArray.count);
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (void)uploadImage {

    [self showLoading];
    NSString *imagePath =  [FilePathManager saveImageFile:self.imageIcon toFolder:@"gange"];
    NSString *uploadpath = [NSString stringWithFormat:@"%@/%@",[FilePathManager getDocumentPath:@""],imagePath];
    
    NSMutableArray *arrayImage = [NSMutableArray array];
    [arrayImage addObject:self.imageIcon];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:API_PhotoUpload parameters:@{@"file":uploadpath} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i<arrayImage.count; i++) {
            UIImage *uploadImage = arrayImage[i];
            [formData appendPartWithFileData:UIImagePNGRepresentation(uploadImage) name:@"file" fileName:@"test.jpg" mimeType:@"image/jpg"];
        }
    } error:nil];
    
    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    opration.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    opration.responseSerializer = [AFJSONResponseSerializer serializer];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        if ([[result objectForKey:@"status"] isEqualToString:@"ok"]) {
            NSDictionary *image = result[@"image"];
            NSString *imageUrl_ = [NSString stringWithFormat:@"http://pic%@.ajkimg.com/m/%@/%@x%@.jpg",image[@"host"],image[@"id"],image[@"width"],image[@"height"]];
            NSLog(@"%@",imageUrl_);
            [self.arrayImageUrl addObject:imageUrl_];
//            self.iconUrl = imageUrl_;
            if (self.arrayImageUrl.count == self.imagecount) {
                [self requestData];
            }
        }
        [self hiddenLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hiddenLoading];
    }];
    [opration start];
}

- (void)requestData {
    NSString *images = @"";
    for (NSString *image in self.arrayImageUrl) {
        images = [NSString stringWithFormat:@"%@%@|",images,image];
    }
    [FoundsApiManager requestUpdateFoundsInfo:self.foundsModel.identify image:images ResultListModel:^(id response) {
        if ([response[@"errorCode"] integerValue] == 0) {
            [self showToastInfo:@"修改成功"];
        }
    }];
}

- (void)elcImagePickerController:(BK_ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    if ([info count] == 0) {
        return;
    }
    for (NSDictionary *dict in info) {
        self.imagecount ++;
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *newSizeImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(480, 480) interpolationQuality:kCGInterpolationMedium];
        self.imageIcon = newSizeImage;
        [self uploadImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerControllerDidCancel:(BK_ELCImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    UIImage *newSizeImage = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(300, 300) interpolationQuality:kCGInterpolationHigh];
//    self.imageIcon = newSizeImage;
    [self uploadImage];
//    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
