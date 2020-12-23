Trestle.resource(:document_files) do
  menu do
    item :document_files, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :original_format
    column :document_id
    column :transcript
    column :translation_fr
    column :language
    column :comment
    column :persons_position
    column :color
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |document_file|
    text_field :original_format
    text_field :document_id
    text_field :transcript
    text_field :translation_fr
    text_field :language
    text_field :comment
    text_field :persons_position
    text_field :color
  
    row do
      col { datetime_field :updated_at }
      col { datetime_field :created_at }
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
  #   params.require(:document_file).permit(:name, ...)
  # end
end
