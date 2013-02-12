puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'pleasechangeme', :password_confirmation => 'pleasechangeme'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'pleaseneee', :password_confirmation => 'pleaseneee'
puts 'New user created: ' << user2.name