//
//  Constant.h
//  HealthOnPhone
//
//  Created by Akhilesh Mourya on 10/13/14.
//  Copyright (c) 2014 Akhilesh Mourya. All rights reserved.
//


#define _AlertView_With_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}

#define _AlertView_WithOut_Delegate(title, msg, button, buttons...) {UIAlertView *__alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:button otherButtonTitles:buttons];[__alert show];}


#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


//http://www.lequincymarket.fr/webservice/get_restaurant_locate.php

#define REGISTRATION @"http://www.lequincymarket.fr/webservice/user_register.php"

#define LIVE_STATUS @"http://maps.googleapis.com/maps/api/geocode/json?address="


#define LASTER_ALERT @"http://www.lequincymarket.fr/webservice/get_detail.php"


#define LOGIN_FACEBOOK @"http://www.lequincymarket.fr/webservice/register.php"


#define LOGIN_GOOGLE @"http://www.lequincymarket.fr/webservice/register.php"

#define LOGIN @"http://www.lequincymarket.fr/webservice/login.php"

#define FORGOTPASSWORD @"http://www.lequincymarket.fr/webservice/forgot_password.php"


#define NOTES @"http://www.lequincymarket.fr/webservice/add_comment.php"

#define COMMENT_NOTES @"http://www.lequincymarket.fr/webservice/get_detail.php"


#define REGISTERATION @"http://www.lequincymarket.fr/webservice/register.php"

#define REMAINDER @"http://www.lequincymarket.fr/webservice/add_calendar.php"


#define REMAINDERSHOWING @"http://www.lequincymarket.fr/webservice/get_calendar.php"

#define PROFILE_USER @"http://www.lequincymarket.fr/webservice/user_profile.php"

#define ADD_RESTAURANT @"http://www.lequincymarket.fr/webservice/add_restaurant.php"

#define GETREGURANT @"http://www.lequincymarket.fr/webservice/get_restaurant.php"

#define GETREGURANT_LOCATION @"http://www.lequincymarket.fr/webservice/get_restaurant_locate.php"

#define GETCERTIFICATE @"http://www.lequincymarket.fr/webservice/get_restaurant_locate.php"

#define GETREGURANT_LOCATION1 @"http://www.lequincymarket.fr/webservice/get_restaurant_locate.php"

#define SEARCHINGRANTING @"http://www.lequincymarket.fr/webservice/get_restaurant_locate.php"

#define DETAIL_RANTING @"http://www.lequincymarket.fr/webservice/get_special1.php"

#define UPDATEREGURANT_LOCATION @"http://www.lequincymarket.fr/webservice/update_latlong.php"

#define SPECIALITY_REST @"http://www.lequincymarket.fr/webservice/speciality_list.php"


