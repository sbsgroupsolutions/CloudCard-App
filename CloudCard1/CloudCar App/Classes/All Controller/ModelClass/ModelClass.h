//
//  ModelClass.h
//  MagazineApp
//
//  Created by Akhilesh Mourya on 12/18/14.
//  Copyright (c) 2014 Akhilesh Mourya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelClass : NSObject



@property(strong,nonatomic) NSString *Mobileno;
@property(strong,nonatomic) NSString *carno;
@property(strong,nonatomic) NSString *carno1 ;
@property(strong,nonatomic) NSString *carno2 ;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *exdate;
@property(strong,nonatomic) NSString *exdate1;
@property(strong,nonatomic) NSString *exdate2;
@property(strong,nonatomic) NSString *fname;
@property(strong,nonatomic) NSString *lstname;
@property(strong,nonatomic) NSString *nameoncard ;
@property(strong,nonatomic) NSString *nameoncard1 ;
@property(strong,nonatomic) NSString *nameoncard2 ;
@property(strong,nonatomic) NSString *nameyourcard ;
@property(strong,nonatomic) NSString *nameyourcard1;
@property(strong,nonatomic) NSString *nameyourcard2;
@property(strong,nonatomic) NSString *password ;

@property(strong,nonatomic) NSString *username;
@property(strong,nonatomic) NSString *userid;
@property(strong,nonatomic) NSString *secuityno2;
@property(strong,nonatomic) NSString *secuityno1;
@property(strong,nonatomic) NSString *secuityno;

@property(strong,nonatomic) NSString *groupPrimaryKey;
@property(strong,nonatomic) NSString *groupUserid;
@property(strong,nonatomic) NSString *GroupName;
@property(strong,nonatomic) NSString *MemberId;
@property(strong,nonatomic) NSString *status;
@property(strong,nonatomic) NSString *groupIcon;

@property(strong,nonatomic) NSString *likeUserIdTo;
@property(strong,nonatomic) NSString *likeUserIdFrom;
@property(strong,nonatomic) NSString *LikeStatus;
@property(strong,nonatomic) NSString *LikeCount;



@end
