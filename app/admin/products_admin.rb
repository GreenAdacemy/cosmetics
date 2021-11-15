Trestle.resource(:products) do
  collection do
    # Set the default order when manual sorting is not applied
    Product.order(created_at: :asc)
  end

  menu do
    item :products, icon: "fa fa-star"
  end

  active_storage_fields do
    [:images]
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :images ,header: false do |product|
      content_tag :div, class: 'admin-image' do
        content_tag(:div, nil, class: 'thumbnail lozad', 'data-background-image': product.thumbnail_url, src: default_image)
      end.html_safe
    end

    column :name
    column :description
    column :price
    column :status
    column :category, sort: :category_id, class: 'text-capitalize', link: false
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form dialog:true do |product|
    text_field :name
    select :status, Product.statuses.keys.map { |status| [status.humanize, status] }
    tinymce :description, rows: 10
    row do
      col(xs: 6, sm: 6) { number_field :price }
      col(xs: 6, sm: 6) { collection_select :category_id, Category.all, :id, :name }
    end    
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:product).permit(:name, ...)
  # end
  controller do
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
