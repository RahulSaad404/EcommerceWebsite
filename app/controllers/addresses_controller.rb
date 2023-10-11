class AddressesController < ApplicationController

	def new
		@address = Address.new
	end

	def create
		@address = Address.create(create_address_params)
		if @address.save
		 	redirect_to :action => 'show_address'
		else
		 	render 'new'
		end
	end

	def edit
		@address = Address.find(params[:id]).becomes(Address)
	end                               

	def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to :action => 'show_address'
    else
      render 'edit'
    end
	end
  
  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to :action => 'show_address'
  end

	def show_address
		@addresses = current_user.addresses
	end

	private
		def create_address_params
			params.require(:address).permit(:address, :type, :user_id)
		end
end
