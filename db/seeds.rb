# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Invoice.destroy_all
Invoice.create(:name => "Invoice 1", :description => "description 1")
Invoice.create(:name => "Invoice 2", :description => "description 2")
Invoice.create(:name => "Invoice 3", :description => "description 3")
Invoice.create(:name => "Invoice 4", :description => "description 4")
Invoice.create(:name => "Invoice 5", :description => "description 5")
Invoice.create(:name => "Invoice 6", :description => "description 6")
Invoice.create(:name => "Invoice 7", :description => "description 7")
Invoice.create(:name => "Invoice 8", :description => "description 8")
Invoice.create(:name => "Invoice 9", :description => "description 9")

Role.destroy_all
roles = Role.create([{ :name => 'Provider' }, { :name => 'Contacts' }, { :name => 'General User' }])
User.destroy_all

user = User.new(:email => "john@example.com", :password => "password", :first_name => "John", :last_name => "Doe")
user.roles << roles.first
user.save

user = User.new(:email => "melinda@example.com", :password => "password", :first_name => "Melinda", :last_name => "Dee")
user.roles << roles[1]
user.save

user = User.new(:email => "kim@example.com", :password => "password", :first_name => "Kimberly", :last_name => "Mcleod")
user.roles << roles.last
user.save

PostCategory.destroy_all
post_categories = PostCategory.create([{:name => "AVT" }, {:name => "SLP" }, {:name => "Hearing Loss" }, {:name => "Cochlear Implant" }, {:name => "Hearing Aids" }])