#!/usr/bin/env ruby

# SCRIPT NEEDS TO BE FINISHED.


# manage.rb
# quick script to manage it early on in dev. 

# Actual modules we use
require 'rubygems' # Sqlite needs it.
require 'sqlite3' # databases.

# Project code
require './config.rb'


$db = SQLite3::Database.new($sqlite_db_name)
# Our control functions:

# Sites:
def add_site(feed_url,feed_name,feed_type,feed_interval,feed_settings)
	new_site_base = "insert into feeds values("
	new_site_base += "\""+feed_url+"\",\""+feed_name+"\","
	new_site_base += feed_type+",0,"+feed_interval+","+feed_settings
	new_site_base += ");"
	puts new_site_base
	$db.execute(new_site_base)
end

def rm_site(feed_url)
	rm_site_base = "delete from feeds where feed_url="
	rm_site_base += feed_url+";"
	puts rm_site_base
	$db.execute(rm_site_base)
end
# Block list:
def add_block(blocked_phrase,block_type,feed_settings)
	add_block_base = "insert into block_data values("
	add_block_base += "\""+blocked_phrase+"\","
	add_block_base += block_type+","
	add_block_base += feed_settings+");"
	$db.execute(add_block_base)
end

def rm_block() 

end

# List all sites
def list_sites()
	list_sites_query = "select * from feeds;"
	# I just dump them all
	puts $db.execute(list_sites_query)
end
# lists all the blocks.
def list_block()

end
# All articles(Maybe make support for narrowing it down?)
def list_articles()

end


add_site("http://feeds.feedburner.com/techdirt/feed","Techdirt","0","900","0")
list_sites()
