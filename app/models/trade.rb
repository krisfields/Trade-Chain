class Trade < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :date
  #has_many :users
  belongs_to :user
  has_many :results
  has_many :possessions 

  #reject those items nobody wants
  def prune(items)
    wants = []
    # owners = []
    items.each do |item|
      # owners << item.user
      item.user.wants.each do |want|
        if want.possession.trade_id == self.id
          wants << want.possession
        end
      end
    end
    # wants = []
    # owners.each do |owner|
    #   owner.wants.each do |want|
    #     if want.possession.trade_id == self.id
    #       wants << want.possession
    #     end
    #   end
    # end
    items.each do |item|
      if !wants.include?(item)
        items.delete(item)
      end
    end
    items
  end

  #helper method to determine the items that an item's owner would take in trade for it
  def items_children(item, items)
  	user = item.user
    # if item.new_owner
    #   return []
    # end
  	user_wants = user.wants.find_all {|want| items.include?(want.possession) and want.value > item.value and want.possession.new_owner == nil}
  	user_wants.sort! {|x,y| x.value <=> y.value}.reverse
  	children = user_wants.map {|want| want.possession }
  end

  #given an item, finds a route back to itself using depth first recursion, taking care to avoid infinite loops due to interior cycles
  def find_trade(item, items)
  	route = [item]
  	items_children(item, items).each do |child|
      if child.new_owner
        next
      end
  		result = recurse_trade(child, route, items)
      #not confident with the next line
      if result and result.count > 0
        puts "ACTUAL RESULT? FIND_TRADE RESULT COUNT = #{result.count}"
        puts "RESULT FIRST IS #{result.first.name}"
        puts "RESULT LAST IS #{result.last.name}"
        return result
      end
  		# return result if result
  	end
  end

  #traverse tree again and again until all paths are exhausted or node equals the item we're looking to trade.  Visited helps us avoid going in infinite loops.  
  def recurse_trade(node, route, items, visited={})
  	if node == route[0]
  		route << node
  		return route
  	elsif visited[node]
  		return
  	else
  		visited[node] = true
  		route << node
  		items_children(node, items).each do |child|
        if child.new_owner
          next
        end
  			result = recurse_trade(child, route, items, visited)
        if result and result.count > 1
          # puts "RESULT is #{result.count}"
          # puts "Result first is #{result.first}"
          # puts "Result last is #{result.last}"
          return result
        else
        end
  			# return result if result
  		end
  	end		
  end

  #cycles through remaining items, starting the search for available routes.  Creates Result objects for all parts of a route found.
  def find_some_trades(items)
    item_count = items.count
    route_count = 0
    items_in_all_routes = 0
    items_that_get_saved = 0
    while items.count > 1
      # puts "ITEMSCOUNT = #{items.count}"
      items = prune(items)
      # puts "ITEMSCOUNT AFTER PRUNE = #{items.count}"
      items_with_new_owners=[]
      items.each do |item|
        if item.new_owner
          next
        end
        #puts "items_with_new_owners size = #{items_with_new_owners.size}"
        #never looping past first item.  so route is always true.  
        	route = find_trade(item, items)
        	if route.count > 2 and route.first == route.last
            route_count +=1
            items_in_all_routes += route.count -1
            #-1 to adjust for index starting at 0.  -1 more because 1st and last item in route is the same.  only need to set owner and delete it once.
        		#each item in a route now has a new owner which is the current owner of the previous item in the route
            0.upto(route.length-2) do |i|
        			possession = Possession.find(route[i+1])
              puts "POSSESSION #{i+1} IN ROUTE #{route_count}: #{possession.name}"
        			possession.new_owner = route[i].user.id
        			possession.save
              items_that_get_saved +=1
              #puts "Route[i] = #{route[i].name}"
        			#items.delete(route[i])
              items_with_new_owners << route[i]
              #puts "and if i try to call the deleted item?"
             # p items.include?(route[i])
        		end
            #break
        	end
      end
      items_with_new_owners.each do |item|
        puts "deleting item: #{item.name}"
        # puts "item count before delete = #{items.size}"
        # puts "Does items include item?  #{items.include?(item)}"
        items.delete(item)
        # puts "item count after delete = #{items.size}"
      end
      if item_count == items.count
        break
      else
        item_count = items.count
      end
    end
    puts "ROUTE COUNT = #{route_count}"
    puts "ITEMS IN ROUTES = #{items_in_all_routes}"
    puts "ITEMS THAT GET SAVED = #{items_that_get_saved}"
  end

  #Initialize items to those belonging to trade.  Prune.  Then find some trades.
  def get_results
  	items = self.possessions.find(:all, :limit => 20, :order => 'wants_count DESC')
    #reset data just for testing
    Possession.all.each do |item|
      item.new_owner = nil
      item.save
    end
  	# items = prune(items)
  	if items.count > 1
  		find_some_trades(items)
  	end
  end

end