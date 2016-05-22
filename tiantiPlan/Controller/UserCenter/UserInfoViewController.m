//
//  UserInfoViewController.m
//  tiantiPlan
//
//  Created by liujianzhong on 16/4/23.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UserInfoViewController.h"
#import "TouristInputInfoViewController.h"
#import "BK_ELCAlbumPickerController.h"
#import "BK_ELCImagePickerController.h"
#import "UserCenterApiManager.h"
#import "CommonViewCell.h"
#import "FilePathManager.h"
#import "DSConfig.h"
#import "UserCacheBean.h"

@interface UserInfoViewController () <UITableViewDelegate, UITableViewDataSource, TouristInputInfoViewControllerDelegate, UIActionSheetDelegate, UINavigationBarDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) UIImage *imageIcon;
@property (nonatomic, strong) NSString *stringNuckname;
@property (nonatomic, strong) NSString *iconUrl;

@end

@implementation UserInfoViewController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = DSBackColor;
    }
    return _tableView;
}

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
    self.arrayData = [NSMutableArray arrayWithObjects:@"头像",@"昵称", nil];
}

- (void)initUI {
    [self setTitle:@"编辑个人资料"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self setRightButtonWithTitle:@"提交"];
}

- (void)takePictureOrLibrary {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [action showInView:self.view];
}

- (void)didRightClick {
    [self uploadImage];
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
            self.iconUrl = imageUrl_;
            [self requestData];
        } else {
            [self requestData];
        }
        [self hiddenLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hiddenLoading];
    }];
    [opration start];
}

- (void)requestData {
    if (self.stringNuckname.length < 1) {
        [self showToastInfo:@"请输入昵称"];
        return;
    }
    if (self.iconUrl.length < 7) {
        [self showToastInfo:@"请上传用户头像"];
        return;
    }
    
    [UserCenterApiManager requestUpdateUserInfo:@{@"userId":[UserCacheBean share].userInfo.userId == nil?@"":[UserCacheBean share].userInfo.userId, @"name":self.stringNuckname, @"icon":self.iconUrl, @"address":[UserCacheBean share].userInfo.address==nil?@"":[UserCacheBean share].userInfo.address, @"date":[UserCacheBean share].userInfo.date==nil?@"":[UserCacheBean share].userInfo.date, @"phone":[UserCacheBean share].userInfo.phone==nil?@"":[UserCacheBean share].userInfo.phone} InfoModel:^(id response) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            static NSString *identify = @"identify0";
            CommonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[CommonViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:60];
            }
            [cell configCellWithData:self.arrayData[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 55, 10, 40, 40)];
            image.image = self.imageIcon;
            [cell addSubview:image];
            return cell;
        }
            break;
        case 1:
        {
            static NSString *identify = @"identify1";
            CommonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (cell == nil) {
                cell = [[CommonViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                [cell showUnderLineAt:60];
            }
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 25, 60)];
            label.text = self.stringNuckname;
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = DSColor;
            label.textAlignment = NSTextAlignmentRight;
            [cell addSubview:label];
            [cell configCellWithData:self.arrayData[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            //头像
            [self takePictureOrLibrary];
        }
            break;
        case 1:
        {
            TouristInputInfoViewController *controller = [[TouristInputInfoViewController alloc] init];
            [controller setTitle:@"昵称"];
            //            controller.textContent.text = self.viewLoveName.textInput.text;
            controller.delegate = self;
            controller.tag = 1;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}


- (void)didUploadInfoWith:(NSString *) content tag:(NSInteger) tag {
    self.stringNuckname = content;
    [self.tableView reloadData];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera; //拍照
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        }
            break;
        case 1:
        {
            BK_ELCAlbumPickerController *albumPicker = [[BK_ELCAlbumPickerController alloc] initWithStyle:UITableViewStylePlain];
            BK_ELCImagePickerController *elcPicker = [[BK_ELCImagePickerController alloc] initWithRootViewController:albumPicker];
            elcPicker.maximumImagesCount = 1 ; //(maxCount - self.roomImageArray.count);
            elcPicker.imagePickerDelegate = self;
            [self presentViewController:elcPicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)elcImagePickerController:(BK_ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    if ([info count] == 0) {
        return;
    }
    int tempNum = 1;
    for (NSDictionary *dict in info) {
        
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        self.imageIcon = image;
    }
    [self uploadImage];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerControllerDidCancel:(BK_ELCImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.imageIcon = image;
    [self uploadImage];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
