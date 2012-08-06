class Trade < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :date
  #has_many :users
  belongs_to :user
  has_many :results
  has_many :possessions

  #reject those items nobody wants
  def initial_prune(items)
  	puts "Z"*10
  	p items
  	i=items.reject {|i| i.wants_count == nil}
  	puts "ARGLE"
  	p i
  	i
  end

  #reject those items that nobody wants again, with new set of items
  # def possession_wanted?(possession, items)
  # 	user=possession.user
  # 	wanted = []
  # 	items.each do |i|
  # 		i.wants.each do |w|
  # 			wanted << w
  # 		end
  # 	end
  # 	wanted.any? {|w| w.possession_id = possession}
  # end

  # def has_children?(possession, items)
  	
  # end

  #helper method to determine the items that an item's owner would take in trade for it
  def items_children(item)
  	user = item.user
  	user_wants = user.wants.find_all {|want| want.possession.trade_id = self.id and want.value > item.value}
  	user_wants.sort! {|x,y| x.value <=> y.value}.reverse
  	children = user_wants.map {|want| want.possession }
  	puts "lol"*10
  	puts "item #{item.id} wants "
  	p children
  	children
  end

  #given an item, finds a route back to itself using depth first recursion, taking care to avoid infinite loops due to interior cycles
  def find_trade(item)
  	puts "E"*10
  	p item
  	route = [item]
  	items_children(item).each do |child|
  		result = recurse_trade(child, route)
  		return result if result
  	end
  end

  #traverse tree again and again until all paths are exhausted or node equals the item we're looking to trade.  Visited helps us avoid going in infinite loops.  
  def recurse_trade(node, route, visited={})
  	if node == route[0]
  		route << node
  		return route
  	elsif visited[node]
  		return
  	else
  		visited[node] = true
  		route << node
  		items_children(node).each do |child|
  			result = recurse_trade(child, route, visited)
  			return result if result
  		end
  	end		
  end

  #cycles through remaining items, starting the search for available routes.  Creates Result objects for all parts of a route found.
  def find_some_trades(items)
  	route = find_trade(items.first)
  	puts "G"*100
  	p route
  	if route
  		puts "Q"*10
  		p route
  		0.upto(route.length-2) do |i|
  			possession = Possession.find(route[i])
  			possession.new_owner = route[i+1].user.id
  			possession.save
  			#Result.create(giver: route[i].id, receiver: route[i+1].id, trade_id: self.id)
  			items.delete(route[i])
  		end
  	end
  end

  #Initialize items to those belonging to trade.  Prune.  Then find some trades.
  def get_results
  	items = self.possessions.find(:all, :order => 'wants_count DESC')
  	items = initial_prune(items)
  	puts "C"*10
  	p items
  	if items
  		find_some_trades(items)
  	end
  end

end