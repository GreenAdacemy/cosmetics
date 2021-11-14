Trestle.resource(:products) do
  menu do
    item :products, icon: "fa fa-star"
  end

  active_storage_fields do
    [:images]
  end

  # Customize the table columns shown on the index view.
  #
  table do
    # column :images ,header: false do |product|
    #   content_tag :div, class: 'admin-image' do
    #     content_tag(:div, nil, class: 'thumbnail lozad', 'data-background-image': thumbnail(product.thumbnail), src: default_image)
    #   end.html_safe
    # end

    column :name
    column :description
    column :price
    column :status
    column :category, sort: :category_id, class: 'text-capitalize', link: false
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form dialog:true  do |product|
    text_field :name
    text_area :description
    number_field :price
    tag_select :ingredients
    # select :category_id, Category.all.map{|obj| [obj.name, obj.id ] }
    collection_select :category_id, Category.all, :id, :name
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
end
