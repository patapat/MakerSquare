
class Bank
	attr_reader :bank_name, :account_balance, :cc_outstanding_balance

	def initialize(bank_name, account_balance = {}, cc_outstanding_balance = {})
		@bank_name = bank_name
		@account_balance = account_balance
		@cc_outstanding_balance = cc_outstanding_balance
		puts "#{bank_name} bank was just created."
	end
	
	def open_account(user)
		@account_balance[user.name] = 0
		puts "#{user.name}, thanks for opening an account at #{@bank_name}!"
	end

	def deposit(user, amount)
		if amount > user.cash
			puts "#{user.name} does not have enough cash to deposit $#{amount}."
		else
			user.cash -= amount
			@account_balance[user.name] += amount
			puts "#{user.name} deposited $#{amount} to #{@bank_name}. #{user.name} has $#{user.cash}. #{user.name}'s account has $#{@account_balance[user.name]}."
		end
	end

	def withdraw(user, amount)
		if amount > @account_balance[user.name]
			puts "#{user.name} does not have enough money in the account to withdraw $#{amount}."
		else
			user.cash += amount
			@account_balance[user.name] -= amount
			puts "#{user.name} withdrew $#{amount} from #{@bank_name}. #{user.name} has $#{user.cash}. #{user.name}'s account has $#{@account_balance[user.name]}"
		end
	end

	def transfer(user, bank, transfer_bank_amount)
		@account_balance[user.name] -= transfer_bank_amount
		bank.account_balance[user.name] += transfer_bank_amount
		puts "#{user.name} transfered $#{transfer_bank_amount} from the #{self.bank_name} account to the #{bank.bank_name} account. The #{self.bank_name} account has #{@account_balance[user.name]} and the #{bank.bank_name} account has $#{bank.account_balance[user.name]}."
	end

	def total_cash_in_bank
		total_cash = 0
		@account_balance.each do |k, v|
			total_cash += v
		end
		puts "#{@bank_name} has $#{total_cash} in the bank."
	end

	def open_cc_account(user)
		@cc_outstanding_balance[user.name] = 0
		puts "#{user.name}, you have been approved for a #{bank_name} credit card! You have a balance of $#{@cc_outstanding_balance[user.name]}. Spend wisely!"
	end

	def cc_charge(user, cc_charge_amount)
		cc_max_limit = 2000
		if cc_max_limit >= @cc_outstanding_balance[user.name] + cc_charge_amount
			cc_credit_remaining = cc_max_limit - @cc_outstanding_balance[user.name] + cc_charge_amount
			@cc_outstanding_balance[user.name] += cc_charge_amount
			cc_credit_remaining = cc_max_limit - @cc_outstanding_balance[user.name]
			puts "#{user.name}, your charge of $#{cc_charge_amount} has been processed. Your current balance for #{bank_name} is $#{cc_outstanding_balance[user.name]} and you have $#{cc_credit_remaining} of credit remaining."
		else
			cc_credit_remaining = cc_max_limit - @cc_outstanding_balance[user.name]
			puts "Sorry, #{user.name} your charge of $#{cc_charge_amount} cannot be processed. Your current balance is $#{cc_outstanding_balance[user.name]} and you have $#{cc_credit_remaining} of credit remaining."
		end
	end

	def cc_balance(user)
		puts "#{user.name}, you owe $#{@cc_outstanding_balance[user.name]}. Would you like to pay? (Y/N)"
		response = gets.chomp
		if response.downcase == "y"
			puts "Please enter amount you would like to pay. Your balance is $#{@cc_outstanding_balance[user.name]}:"
			pay_response = gets.chomp
			self.cc_pay(user, pay_response)
		else
			puts "Have a great day!"
		end
	end
	def cc_pay(user, pay_amount)
		pay_amount_int = pay_amount.to_i
		if pay_amount_int > @account_balance[user.name]
			puts "You have insufficient funds, your current account balance is $#{@account_balance[user.name]}."
		else
			@cc_outstanding_balance[user.name] -= pay_amount_int
			@account_balance[user.name] -= pay_amount_int
			puts "You've paid $#{pay_amount_int}, your credit card balance is $#{@cc_outstanding_balance[user.name]}. You have $#{@account_balance[user.name]} left in your #{bank_name} account."
		end
	end
end
class Person
	attr_reader :name
	attr_accessor :cash

	def initialize(name, cash)
		@name = name
		@cash = cash
		puts "Hi, #{name}. You have $#{@cash}!"
	end
end


chase = Bank.new("JP Morgan Chase")
wells_fargo = Bank.new("Wells Fargo")
me = Person.new("Shehzan", 500)
friend1 = Person.new("John", 1000)
chase.open_account(me)
chase.open_account(friend1)
wells_fargo.open_account(me)
wells_fargo.open_account(friend1)
chase.deposit(me, 200)
chase.deposit(friend1, 300)
chase.withdraw(me, 50)
chase.transfer(me, wells_fargo, 100)
puts chase.bank_name
chase.deposit(me, 5000)
chase.withdraw(me, 5000)
print chase.total_cash_in_bank
print wells_fargo.total_cash_in_bank
chase.open_cc_account(me)
chase.open_cc_account(friend1)
wells_fargo.open_cc_account(me)
wells_fargo.open_cc_account(friend1)
chase.cc_charge(me, 500)
chase.cc_charge(friend1, 300)
wells_fargo.cc_charge(me, 200)
wells_fargo.cc_charge(friend1, 400)
wells_fargo.cc_charge(me, 200)
wells_fargo.cc_charge(friend1, 400)
wells_fargo.cc_charge(friend1, 1400)
chase.cc_balance(me)
chase.cc_balance(friend1)
wells_fargo.cc_balance(me)
wells_fargo.cc_balance(friend1)