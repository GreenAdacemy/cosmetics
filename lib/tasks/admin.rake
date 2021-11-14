namespace :admin do
  desc 'Create default admin account for Admin page'
  task init: :environment do
    if Administrator.count == 0 
      Administrator.create(
        email: 'admin@cosmetic.vn',
        password: 'admin@123456',
        password_confirmation: 'admin@123456',
        first_name: 'Admin',
        last_name: ''
      )
      puts 'Admin site created, please use account/password admin@cosmetic.vn/admin@123456'
    else
      puts 'Admin site has been already account, please use account/password admin@cosmetic.vn/admin@123456'
    end
  end
end
