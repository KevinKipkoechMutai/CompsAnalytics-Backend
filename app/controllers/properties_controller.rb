class PropertiesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unproccessable_entity_response
def index
  render json: Property.all, status: :ok
end
def create 
  property = Property.create!(property_params)
  render json: property
end
def show
  property = Property.find_by(id: params[:id])
  if property
      render json: property
  else
      render json: {error: "Property not found"}, status: :not_found
  end
end
def patch
  property = Property.find_by(id: params[:id])
  if property
     property = Property.update!(property_params)
     render json: property 
  else
      render json: {error: "Property not found"}, status: :not_found
  end
end
def destroy
  property = Property.find_by(id: params[:id])
  if property
      property.destroy
      head :no_content
  else
      render json: {error: "Property not found"}, status: :not_found 
  end
end

def valuation_create
  @property_data = Property.new(property_data_params)
  @comparable_properties = ComparableProperty.create(comparable_properties_params)
  @property_valuation = property_valuation(@property_data, @comparable_properties)

end



# valuation algorithm
def property_valuation(property_data, comparable_properties)
  # Extract relevant data from property_data
  location = property_data[:location]
  size = property_data[:size]
  category = property_data[:category]
  title = property_data[:title]
  time = Time.now

  # Compare the property to similar properties in the area
  comparable_values = []
  comparable_sizes = []
  comparable_properties.each do |prop|
    comparable_location = prop[:location]
    comparable_category = prop[:category]
    comparable_size = prop[:size]
    comparable_value = prop[:value]
    
    if location == comparable_location && category == comparable_category
      comparable_values << comparable_value && comparable_sizes << comparable_size
    end
  end

  # Take the average of the comparable values
  if comparable_values.length > 0 && comparable_sizes.length > 0
    comparable_value_analysis = comparable_values.sum / comparable_values.length
    comparable_size_analysis = comparable_sizes.sum / comparable_sizes.length
    comparable_valuation_rate = comparable_value_analysis / comparable_size_analysis
    # Adjust the valuation based on the size of the property
    valuation = comparable_valuation_rate * size
  end
  
 render json: {title: title, valuation: valuation, time: time, document_analysed: comparable_values.length}
end


def render_unproccessable_entity_response(error)
  render json: {errors: error.record.errors.full_message}, status: :unproccessable_entity
end

private
def property_data_params
  params.require(:property).permit(:location, :size, :category, :title)  
end

private
def property_params
  params.permit([:location, :size, :category, :title,:image,:lr_no,:analysis,:description,:value])  
end

def comparable_properties_params
  params.require(:comparable_properties).map { |c| c.permit(:location, :size, :category, :value) }
end
end