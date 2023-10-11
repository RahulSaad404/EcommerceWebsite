class A

 def name(*args)
 	alphabet = args.join('')
 	puts alphabet
 	last_name
 end
 private
 	def last_name
 		puts "private method called"
 	end
 	protected
 	 def name3
 	 	puts 'protected method'
 	 end
end
obj = A.new
obj.send :name,'A','B','C','D'
obj.name('A','B','C','D')
obj.send :name3
