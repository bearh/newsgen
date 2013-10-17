#!/usr/bin/env ruby

# scheduler.rb
# Downloads the feeds, stores them in cache/raw_feeds/

require 'rubygems'
require 'sqlite3'
require 'digest/sha1'

# Project code
require './config.rb'

# simple hash gen.
def gen_article_hash(time,title,link)
	return Digest::SHA1.digest(time+title+link)
end

# If article already exists in the database, it will return true, else false.
def check_article_exists(hash)
	result_list = $db.execute("select * from feeds_data where hash=\""+hash+"\";")
	if result_list != NULL
		return true
	else 
		return false
	end
end

# Checks if article exists and then adds it to the db if it doesn't.
# returns false if the article is already in the db.
def add_article(time,title,link,author)
	hash_article = gen_article_hash(time,title,link)
	if check_article_exists(hash_article) == true
		return false
	end
	add_article_sql = "insert into feeds_data values("
	add_article_sql += time+",\""+title+"\",\""+link+"\",\""+author+"\");"
	$db.execute(add_article_sql)
end

# Parses feed.
