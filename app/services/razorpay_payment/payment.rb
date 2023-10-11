module RazorpayPayment
	class Payment
  	require "razorpay"
		Razorpay.setup(ENV['razorpay_id'], ENV['razorpay_secret_key'])
    
  	def create_order_payment(amount,receipt)
			Razorpay::Order.create amount: amount*100, currency: 'INR',receipt: receipt
		end

		def varify_payment(temp)
			payment_response = {razorpay_order_id: temp[:razorpay_order_id],razorpay_payment_id: temp[:razorpay_payment_id],
        razorpay_signature: temp[:razorpay_signature_id] }

			   Razorpay::Utility.verify_payment_signature(payment_response)
		end
		
	end
end


# begin
#         debugger
# 			   var = Razorpay::Utility.verify_payment_signature(payment_response) 
# 			 	rescue Exception(var)

# 			 	puts "payment failed"	
# 			 	debugger
# 			end
