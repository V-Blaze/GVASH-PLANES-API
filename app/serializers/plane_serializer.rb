class PlaneSerializer
  include JSONAPI::Serializer
  attributes :name, :plane_type, :image, :year_of_manufacture, :created_at, :updated_at
end
