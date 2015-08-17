require "sinatra"
require "sinatra/flash"

post "/" do
	text = params[:text].strip
	tokens = text.split("d")
	user = params[:user_name]
	@rolls = []
	if tokens.length == 1
		dice = 1
		dicerange = tokens[1].to_i
	else
		dice = tokens[0].to_i
		dicerange = tokens[1].to_i
	end
	if tokens.last == "!"
		explode = true
	else
		explode = false
	end
	dice.times do |i|
		roll = Random.rand(dicerange)
		@rolls.push(roll)
		if explode and roll == dicerange
			@rolls.push(Random.rand(dicerange))
		end
	end
	<<-TEXT
		#{user} rolled: #{@rolls}
	TEXT
end

get "/" do
	erb :index
end