namespace :user do
  desc 'Init default user for project'
  task init: :environment do
    User.destroy_all
    (1..3).each do |index|
      User.create(
        email: 'user%02d@gmail.com' % index, 
        password: '123456', 
        password_confirmation: '123456', 
        profile_attributes: {
          name: 'user-%02d' % index, 
          phone: '0908899%03d' % index
        }, 
        addresses_attributes: [
          {
            address: 'address %05d' % index, 
            primary: true
          }
        ]
      )
    end
  end
end
