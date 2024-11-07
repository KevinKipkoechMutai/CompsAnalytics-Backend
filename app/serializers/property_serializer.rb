class PropertySerializer < ActiveModel::Serializer
  attributes :id, :image, :lr_no, :location, :category,:title, :analysis, :description, :size, :value
end
