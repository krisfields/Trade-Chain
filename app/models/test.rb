    items = []
    1.upto(100) do |l|
      items << l
    end
    puts "#{items.inspect}"
    item_count = items.count
    while items.count > 0
      items_with_new_owners=[]
      items.each do |item|
        if (item % (rand(10)+1)) == 0
          items_with_new_owners << item
        end
      end
      items_with_new_owners.each do |item|
        puts "deleting item: #{item}"
        puts "item count before delete = #{items.size}"
        puts "Does items include item?  #{items.include?(item)}"
        items.delete(item)
        puts "item count after delete = #{items.size}"
      end
      puts "About to check items.count=#{items.count.inspect}"
      if item_count == items.count
        puts "Qutting because of item_count == items.count"
        break
      else
        item_count = items.count
      end
    end