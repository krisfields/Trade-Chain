class Trade < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :date
  #has_many :users
  belongs_to :user
  has_many :results
  has_many :possessions

  #reject those items nobody wants
  def initial_prune(items)
  	items.reject {|i| i.wants_count == nil}
  end

  #reject those items nobody wants
  def prune(items)
    owners = []
    items.each do |item|
      owners << item.user
    end
    wants = []
    owners.each do |owner|
      owner.wants.each do |want|
        wants << want.possession
      end
    end
    items.each do |item|
      if !wants.include?(item)
        items.delete(item)
      end
    end
    items
  end

  #helper method to determine the items that an item's owner would take in trade for it
  def items_children(item)
  	user = item.user
  	user_wants = user.wants.find_all {|want| want.possession.trade_id = self.id and want.value > item.value}
  	user_wants.sort! {|x,y| x.value <=> y.value}.reverse
  	children = user_wants.map {|want| want.possession }
  end

  #given an item, finds a route back to itself using depth first recursion, taking care to avoid infinite loops due to interior cycles
  def find_trade(item)
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
    while items.count > 0
      prune(items)
      items.each do |item|
        puts "TEST"*10
        puts item.name
      	route = find_trade(item)
      	if route
      		0.upto(route.length-2) do |i|
      			possession = Possession.find(route[i])
      			possession.new_owner = route[i+1].user.id
      			possession.save
      			items.delete(route[i])
      		end
      	end
      end
    end
  end

  #Initialize items to those belonging to trade.  Prune.  Then find some trades.
  def get_results
  	items = self.possessions.find(:all, :order => 'wants_count DESC')
    #reset data just for testing
    items.each do |item|
      item.new_owner = nil
      item.save
    end
  	items = prune(items)
  	if items
  		find_some_trades(items)
  	end
    puts "ITEMS"*10
    p items
  end

end