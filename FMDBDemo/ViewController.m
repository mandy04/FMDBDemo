//
//  ViewController.m
//  FMDBDemo
//
//  Created by llbt on 16/3/30.
//  Copyright © 2016年 llbt. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

//从gitHub下载FMDB https://github.com/ccgus/fmdb
//导入libsqlite3.0.tbd
@interface ViewController ()

@end

static FMDatabaseQueue *queue;

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *filePath = [path stringByAppendingString:@"/student.sqlite"];
    
    NSLog(@"filePath = %@",filePath);
    
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
//    [queue inDatabase:^(FMDatabase *db) {
//        
//        [db executeUpdate:@"insert into person (id,name,sex,telephone) values (?,?,?,?)",@101,@"GG",@"mail",@"686879799"];
//        [db executeUpdate:@"insert into person (id,name,sex,telephone) values(?,?,?,?)",@102,@"MM",@"femail",@"232324423"];
//    }];
    
    //调用inTransaction将需要执行的操作添加到队列中
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (![db executeUpdate:@"insert into person (id,name,sex,telephone) values (?,?,?,?)",@103,@"GGg",@"mail",@"126879799"]) {
            
            //在事务中添加需要执行的操作，出现异常及时回馈
            *rollback = YES;
            return;
        }
        
        if (![db executeUpdate:@"insert into person (id,name,sex,telephone) values (?,?,?,?)",@104,@"MMM",@"femail",@"126879799"]) {
            
            *rollback = YES;
            return;
        }
        
    }];
    
/**
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
    if ([database open]) {
        NSLog(@"open success");
        
        //创建数据表person(id name sex telephone)
        NSString *createSql = [NSString stringWithFormat:@"create table if not exists  person (id interger primary key,name text,sex text,telephone text)"];
        if (![database executeUpdate:createSql]) {
            NSLog(@"create table fail");
        }
*/
    
        /**
         *  插入一条数据1
         */
    
    /*
        NSString *insertSql = [NSString stringWithFormat:@"insert into person (id, name, sex, telephone) values (%d,'%@','%@','%@')",1,@"lucy",@"femail",@"13700892290"];
        if (![database executeUpdate:insertSql]) {
            NSLog(@"insert row fail");
        }
        
        //在executeUpdate后面直接添加sql语句时，使用？代表oc对象，integer对应NSnumber,text对应NSString,block对应NSdata
        if (![database executeUpdate:@"insert into person (id,name,sex,telephone) values (?,?,?,?)",@4,@"lily",@"mail",@"22222222222"]) {
            NSLog(@"insert 2 fail");
        }
   */
        /**
         *  修改数据
         */
/*
        NSString *updateSql = [NSString stringWithFormat:@"update person set name = '%@' where id = 1",@"mike"];
        if (![database executeUpdate:updateSql]) {
            NSLog(@"update fial");
        }
*/
        
        /**
         *  删除
         */
/*
        NSString *deleteSql = [NSString stringWithFormat:@"delete from person where id = 1"];
        if (![database executeUpdate:deleteSql]) {
            NSLog(@"delete fail");
        }
        
 */
        
        /**
         *  查询
         */
        
/**
        NSString *selectSql = [NSString stringWithFormat:@"select * from person"];
        //使用FMResultSet保存
        FMResultSet *rs = [database executeQuery:selectSql];
        
        while ([rs next]) {
            //使用字段位置查询
            NSLog(@"id = %d",[rs intForColumnIndex:0]);
            NSLog(@"name = %@",[rs stringForColumnIndex:1]);
            NSLog(@"sex = %@",[rs stringForColumnIndex:2]);
            NSLog(@"telephone = %@", [rs stringForColumnIndex:3]);
            
        }
    //使用完之后 关闭数据表
        
        [database close];
 **/
    
    
/**
        
    }else {
        NSLog(@"open failed");
    }
*/
        
        
        //多线程的使用
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
