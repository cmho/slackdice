require "sinatra"
require "sinatra/flash"

post "/" do
	text = params[:text].strip
	tokens = text.split("d")
	user = params[:user_name]
	@rolls = []
	explode = false
	if tokens.length == 1
		dice = 1
		if tokens[0].include?("!")
			explode = true
			dicerange = tokens[0].chop.to_i
		else
			dicerange = tokens[0].to_i
		end
	else
		dice = tokens[0].to_i
		if tokens[1].include?("!")
			explode = true
			dicerange = tokens[1].chop.to_i
		else
			dicerange = tokens[1].to_i
		end
	end
	dice.times do |i|
		roll = Random.rand(1..dicerange)
		@rolls.push(roll)
		if explode and roll == dicerange
			@rolls.push(Random.rand(1..dicerange))
		end
	end
	<<-TEXT
		#{user} rolled: #{@rolls}
	TEXT
end

get "/" do
	erb :index
end