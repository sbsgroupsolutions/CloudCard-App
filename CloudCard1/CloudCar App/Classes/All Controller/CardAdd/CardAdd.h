//
//  CardAdd.h
//  
//
//  Created by Admin on 10/10/16.
//
//
#import "SBJson.h"
#import "AFNetworking.h"
#import "ConstantFinal.h"
#import <UIKit/UIKit.h>

@interface CardAdd : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextViewDelegate> {

    IBOutlet UICollectionView *collectionview;
    NSMutableArray *arrCard;
}
@property(strong,nonatomic)NSString * strCardlist;
@property(strong,nonatomic)NSString * GroupCardNameCurrent;
@property(strong,nonatomic)NSString * imgCardGroupCurrent;
@property (strong, nonatomic) NSData *imageCardDataCl;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtAccount;
@property (strong, nonatomic) IBOutlet UITextField *txtOrganisation;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
- (IBAction)ActionCardAdd:(id)sender;

- (IBAction)ActionBack:(id)sender;
- (IBAction)ActionDollor:(id)sender;
- (IBAction)ActionPerc:(id)sender;
- (IBAction)ActionAddCard:(id)sender;

@end
