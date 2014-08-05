#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'chef/config'
require 'chef/knife'
require 'chef/data_bag_item'
require 'chef/search/query'
require 'chef/mixin/xml_escape'

include Chef::Mixin::XMLEscape

	set :bind, '0.0.0.0'
	config = File.expand_path("../config/knife.rb",File.dirname( __FILE__))
	Chef::Config.from_file(config)
	puts Chef::Config.inspect
	puts Dir.tmpdir

	get "/role/:role" do |r|
		content_type 'text/xml'
		Chef::Log.info("Loading nodes for #{r}")
		send_file build_xml(r)
	end


	def build_xml(role)
	begin
		
		query = Chef::Search::Query.new
		servers = query.search(:node, "role:#{role}")[0]
		puts servers.inspect
		response = File.open("#{Dir.tmpdir}/chef-rundeck-#{role}.txt", 'w')
		response.write '<?xml version="1.0" encoding="UTF-8"?>'
	  	response.write '<!DOCTYPE project PUBLIC "-//DTO Labs Inc.//DTD Resources Document 1.0//EN" "project.dtd">'
	  	response.write '<project>'
			servers.each do |node|
				response.write "<node name=\"#{xml_escape(node.name)}\" type=\"Node\" description=\"\" osArch=\"\" osFamily=\"unix\" osName=\"\" osVersion=\"\" username=\"root\" hostname=\"#{node.name}\" tags=\"\" />"
			end
		response.write "</project>"
		response.close
		return response.path
	end

end
