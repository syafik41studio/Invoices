require 'rubygems'
require 'faker'

2.times do
	p = User.new(:email=>Faker::Internet.email,
	:password => "secret"
	)

	if (!p.valid?)
		p.errors.each_full {|msg| puts msg}
	else
		p.save
	end 
end 
