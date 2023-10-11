require 'csv'
require 'open-uri'
class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      @savecount = 0
      @notsavecount = 0
      CSV.parse(csv_file) do |row|
        target_model = model_name.classify.constantize
        new_object = target_model.new
        column_iterator = -1
        target_model.column_names.each do |key|
          next if key == 'id' or key == 'created_at' or key == 'updated_at'
          column_iterator += 1  
          if key == 'category_id'
            value = Category.find_by(category_name:row[column_iterator]).id
            new_object.send "#{key}=", value
          else
            value = row[column_iterator]
            new_object.send "#{key}=", value
          end
        end
        if new_object.stock == 0
          @notsavecount += 1 
        else
          new_object.save
          @savecount +=1
          unless row[column_iterator+1] == nil 
            new_object.image.attach(io: open(row[column_iterator+1]), filename: row[column_iterator+1], content_type: 'image/webp')
          end
        end
      end
      return @savecount,@notsavecount
    end 
  end
end
