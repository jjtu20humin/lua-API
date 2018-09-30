#!/bin/sh
data='data={"id":1894365135,"idstr":"1894365135","class":1,"screen_name":"ytsunlei","name":"ytsunlei","province":"31","city":"4","location":"上海 徐汇区","description":"","url":"","profile_image_url":"http://tp4.sinaimg.cn/1894365135/50/0/1","profile_url":"u/1894365135","domain":"","weihao":"","gender":"m","followers_count":17,"friends_count":79,"statuses_count":35,"favourites_count":0,"created_at":"Wed Nov 23 18:38:45 +0800 2011","following":false,"allow_all_act_msg":false,"geo_enabled":true,"verified":false,"verified_type":-1,"remark":"","status":{"created_at":"Tue Feb 25 18:02:24 +0800 2014","id":3681923971043880,"mid":"3681923971043880","idstr":"3681923971043880","text":"现在下载来往，注册后在“我的-邀请”输入我的暗号：jd34kf，我们都能获得5元奖励。下载地址：http://t.cn/8FmeEz2","source":"<a href=\"http://app.weibo.com/t/feed/6tbQhM\" rel=\"nofollow\">小米手机2</a>","favorited":false,"truncated":false,"in_reply_to_status_id":"","in_reply_to_user_id":"","in_reply_to_screen_name":"","pic_urls":[],"geo":null,"annotations":[{"client_mblogid":"2cd339c0-1ccc-4436-8e4c-b3608a5d04c6"}],"reposts_count":0,"comments_count":0,"attitudes_count":0,"mlevel":0,"visible":{"type":0,"list_id":0}},"ptype":0,"allow_all_comment":true,"avatar_large":"http://tp4.sinaimg.cn/1894365135/180/0/1","avatar_hd":"http://tp4.sinaimg.cn/1894365135/180/0/1","verified_reason":"","verified_trade":"","verified_reason_url":"","verified_source":"","verified_source_url":"","follow_me":false,"online_status":0,"bi_followers_count":10,"lang":"zh-cn","star":0,"mbtype":14,"mbrank":1,"block_word":0,"block_app":0}' 


param='?passwd=123321&uid=testqqid3&utype=openqq&sign=';
param='?smstype=userreg&step=getsms&sign=';
param='?codetype=userreg&uid=13918059797&token=5367ff22aebf1e2b19000001&passwd=111222333&sign=';
param='?codetype=userreg&uid=13918059797&token=5367ff22aebf1e2b19000001&passwd=111222333&regtype=randreg&sign=';
param='?codetype=userreg&uid=13918059797&token=5367ff22aebf1e2b19000001&passwd=111222333&regtype=randreg&sign=';
param='?codetype=userreg&uid=13918059797&openid=535b5ce4aebf1e5e35000001&sign=';
param='?passwd=123321&uid=testqqid3&utype=zhuoyou&step=getsms&sign=';

param='?passwd=e10adc3949ba59abbe56e057f20f883e&uid=15618262164&utype=zhuoyou&sign=';
param='?token=536862efaebf1efa40000001&openid=5358f108aa42b63fb929663e&sign=';
param='?interface=';

echo curl -i -X POST "http://58.32.237.57:7890/lapi/$1"$param$2;
curl -i -X POST -d "$data" "http://58.32.237.57:7890/lapi/$1"$param$2;
