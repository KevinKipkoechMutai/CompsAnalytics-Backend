class ComparablePropertySerializer < ActiveModel::Serializer
  attributes :id, :location, :size, :category, :value, :title
end
