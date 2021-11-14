Trestle.resource(:users) do
  menu do
    item :users, icon: "fa fa-users"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :email
    column :name do |user|
      content_tag :div, user.profile.name
    end
    column :phone do |user|
      content_tag :div, user.profile.phone
    end
    column :address do |user|
      content_tag :div, user.address
    end
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form dialog:true do
    text_field :email 
    row do
      col(sm: 6) { password_field :password }
      col(sm: 6) { password_field :password_confirmation }
    end
    fields_for :profile do
      row do
        col(xs: 6, sm: 6) { text_field :name }
        col(xs: 6, sm: 6) { text_field :phone }
      end
    end
    render "addresses"
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end
  controller do
    def index
      @test='hello world'
    end
    def import
      # @import = ImportManagement.new()
    end

    def import_file
      if params[:import_management]
        import_params = params.require(:import_management).permit(:file)
        ImportManagement.create(
          import_params.merge({from: 'admin:products', to: Product.table_name})
        )
      end
      redirect_to products_admin_index_path
    end
  end

  routes do
    get :import, on: :collection
    post :import_file, on: :collection
  end
end
