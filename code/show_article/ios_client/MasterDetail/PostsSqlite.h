//
//  posts postsSqlite.h
//  MasterDetail
//
//  Created by mac on 13-7-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "/usr/include/sqlite3.h"

@interface PostsSqlite : NSObject {
    sqlite3 *postsDB;
}

+ (bool)initDB: (sqlite3 *)postsDB
        dbPath:(NSString *) dbPath;

+ (bool)isExists: (sqlite3 *)postsDB
          dbPath:(NSString *) dbPath
          postId:(NSString *)postId;

+ (bool)savePost: (sqlite3 *)postsDB
          dbPath:(NSString *) dbPath
          postId:(NSString *)postId
          summary:(NSString *)summary
        category:(NSString *)category
           title:(NSString *)title
         content:(NSString *)content;

+ (bool)loadPosts: (sqlite3 *)postsDB
           dbPath:(NSString *) dbPath
          objects:(NSMutableArray *) objects
        tableview:(UITableView *)tableview;
@end
