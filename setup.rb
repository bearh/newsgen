#!/usr/bin/env ruby

# setup.rb
# This script creates the database.
#
# We have three tables, 'feeds', 'feed_data' and 'block_data'.
# 'feeds' contains the users list of feeds to collect(and all related infomation to obtaining those feeds)
# 'feed_data' contains the data obtained from getting the feeds, such as titles, dates, etc
# 'block_data' Contains data which if found in a URL/Title/Site name, and can apply it to certain ones.

# Actual modules we use
require 'rubygems' # Sqlite needs it.
require 'sqlite3' # databases.

# Project code
require './config.rb'

def create_db()
	# Contains the url, feed type, last updated time, update interval and "feed settings"
	# feed settings lets use use code just for certain feeds. 
	# I wanted this for some google news parsing, etc.
	# Easily hacked to add new stuff.
	create_feeds = """
	create table feeds(
		feed_url char(512),
		feed_type int,
		feed_updated, int,
		feed_interval int,
		feed_settings int
	);"""
	# SHA1 hash(time+title+link), time, title, link, author
	# I don't ever expect you would ever hit those limit. If you do, well fuck.
	create_feeds_data = """
	create table feeds_data(
		hash char(40),
		time int,
		title char(512),
		link char(1024),
		author char(128)
	);"""
	# Blocked phrase/keyword, where it applies(stored using some strange int ;p) feed type(atom/rss), 
	# and the "feed settings"(refer to create_feeds) in which it applies.
	create_block_data = """
	create table block_data(
		blocked_phrase char(128),
		feed_type int,
		feed_settings int
	);""";
	# Create the tables. (maybe check if it already exists?)
	db = SQLite3::Database.new($sqlite_db_name)
	db.execute(create_feeds)
	db.execute(create_feeds_data)
	db.execute(create_block_data)
end
print("Creating db at file: ",$sqlite_db_name)
create_db()
