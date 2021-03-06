# -*- coding: utf-8 -*-
#!/usr/bin/python
##-------------------------------------------------------------------
## @copyright 2013
## File : data.py
## Author : filebat <markfilebat@126.com>
## Description :
## --
## Created : <2013-01-25 00:00:00>
## Updated: Time-stamp: <2013-07-21 21:14:32>
##-------------------------------------------------------------------
import MySQLdb
import config
from util import POST
from util import fill_post_data
from util import fill_post_meta

# sample: data.get_post("ffa72494d91aeb2e1153b64ac7fb961f")
def get_post(post_id):
	conn = MySQLdb.connect(config.DB_HOST, config.DB_USERNAME, \
						 config.DB_PWD, config.DB_NAME, charset='utf8', port=3306)
	cursor = conn.cursor()
	cursor.execute("select id, category, title from posts where id ='%s'" % post_id)
	out = cursor.fetchall()
	cursor.close()
	# todo: defensive check
	post = POST.list_to_post(out[0])
	fill_post_data(post)
	fill_post_meta(post)
	return post

def list_user_post(userid, date):
	conn = MySQLdb.connect(config.DB_HOST, config.DB_USERNAME, config.DB_PWD, \
						 config.DB_NAME, charset='utf8', port=3306)
	cursor = conn.cursor()
	if date == '':
		sql = "select posts.id, posts.category, posts.title " + \
			"from deliver inner join posts on deliver.id = posts.id " + \
			"where userid='%s' order by deliver_date desc" % (userid)
	else:
		sql = "select posts.id, posts.category, posts.title " + \
			"from deliver inner join posts on deliver.id = posts.id " + \
			"where userid='%s' and deliver_date='%s' order by deliver_date desc" % (userid, date)
	cursor.execute(sql)
	out = cursor.fetchall()
	user_posts = POST.lists_to_posts(out)

	if date == '':
		sql = "select posts.id, posts.category, posts.title " + \
			"from deliver, posts, user_group " +\
			"where deliver.id = posts.id and user_group.userid='%s' " +\
			"and user_group.groupid=deliver.userid " +\
			"order by deliver_date desc; " % (userid)

	else:
		sql = "select posts.id, posts.category, posts.title " + \
			"from deliver, posts, user_group " +\
			"where deliver.id = posts.id and user_group.groupid=deliver.userid and " +\
			"user_group.userid='%s' and deliver_date='%s' order by deliver_date desc;" % (userid, date)

	cursor.execute(sql)
	out = cursor.fetchall()
	cursor.close()
	group_posts = POST.lists_to_posts(out)

	return user_posts + group_posts

def list_user_topic(userid, topic, start_num, count):
	conn = MySQLdb.connect(config.DB_HOST, config.DB_USERNAME, config.DB_PWD, \
			config.DB_NAME, charset='utf8', port=3306)
	cursor = conn.cursor()
	if count>0 :
		sql_format = "select id from posts where category = '%s' and num > %d order by num asc limit %d;"
		sql = sql_format % (topic, start_num, count)
	else:
		sql_format = "select id from posts where category = '%s' and num < %d order by num desc limit %d;"
		sql = sql_format % (topic, start_num, -count)
	print sql
	cursor.execute(sql)
	out = cursor.fetchall()
	return out
## File : data.py
