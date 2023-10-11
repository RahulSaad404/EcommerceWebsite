ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :product_name, :product_price, :product_brand, :image, :category_id, :discription, :seller, :stock
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_name, :product_price, :product_brand, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #permit_params  :product_name, :product_brand, :product_price, :category_id 
  
  filter :product_name
  filter :product_brand
  filter :seller
 
  action_item only: :index do
     link_to 'Upload CSV', action: 'upload_csv'
  end

   collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    @count = CsvDb.convert_save("Product", params[:dump][:file])
    redirect_to admin_products_path ,alert: "#{@count.last} products not saved in database because stock value is 0",notice: "successfully! #{@count.first} products uploaded" 
  end

  collection_action :download_csv,method: :get do
    csv_data = "product_name,product_price,product_brand,category,created_at,updated_at,discription,seller,stock,image\nwatch,2999,Noise,Electronics,2023-10-01 05:48:42,2023-10-01 05:48:42,NOISE Legacy 1.43 AMOLED Bluetooth Calling with First Ever Wireless Charging Smartwatch  (Silver Strap),RetailNet,5,///home/rails-010/Downloads/watch2.webp"
    send_data csv_data,filename: 'product_sample.csv'
  end


  batch_action :delete do |ids|
    batch_action_collection.find(ids).each do |product|
      product.destroy 
    end
    redirect_to admin_products_path, alert: "Product destroyed successfully !"
  end

   batch_action :Update_stock_to_10 do |ids|
    batch_action_collection.find(ids).each do |product|
      product.update(stock:10)
    end
    redirect_to admin_products_path, notice: "Product stock updated as 10 stock successfully !"
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do                    
      f.input :category, collection: Category.all.map { |c| [c.category_name,c.id] }, prompt: "select"
      f.input :product_name   # builds an input field for every attribute
      f.input :product_price           
      f.input :product_brand
      f.input :discription
      f.input :seller
      f.input :stock
      if  f.object.image.attached?
        f.input :image, as: :file, hint: image_tag(url_for(f.object.image))
      else
        f.input :image, as: :file
      end
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

#hint: (f.object.image.attached?) ? image_tag(url_for(f.object.image))
  show do
    attributes_table do
      row :product_name
      row :product_price
      row :product_brand
      row :discription
      row :seller
      row :stock
      row :image do |ad|
        if ad.image.attached?
        image_tag url_for(ad.image), size: "150x150"
        end
      end
    end
  end




  # index do
  #   attributes_table do
  #     column :product_name
  #     column :product_brand
  #     column :product_price
  #     column :seller
  #     column :deiscription
  #     column :category do |c|
  #       debugger
  #     end
  #   end
  # end

end
