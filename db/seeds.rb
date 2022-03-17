# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

## Roles ## 
puts "Creating Roles"
sys_admin = Role.create_with(hidden: true).find_or_create_by(name: "System Administrator")
org_owner = Role.create_with(hidden: false).find_or_create_by(name: "Organization Owner")
contributor = Role.create_with(hidden: false).find_or_create_by(name: "Contributor")
viewer = Role.create_with(hidden: false).find_or_create_by(name: "Viewer")
inactive = Role.create_with(hidden: false).find_or_create_by(name: "Inactive")
puts "Roles Created\n"

## Organizations ##

