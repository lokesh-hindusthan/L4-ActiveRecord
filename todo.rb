require "active_record"

class Todo < ActiveRecord::Base
  
  def due_today?
    due_date == Date.today
  end
  
  #ideally overdue, due_today, and due_later would be their own methods
  def self.over_due
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where("due_date = ?", Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end
  
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}.  #{display_status} #{todo_text} #{display_date}"
  end
  
  def self.show_list
    #Then show_list would call it like:
    
    puts "My Todo-list\n\n"
    puts "Overdue\n"
    puts over_due.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    
    puts "Due Today\n"
    puts due_today.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    
    puts "Due Later\n"
    puts due_later.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    
  end
    
  def self.add_task(new_todo)
    Todo.create!(todo_text: new_todo[:todo_text], due_date: Date.today + new_todo[:due_in_days], completed: false)
  end

  def self.mark_as_complete!(todo_id)
    update(todo_id, completed: true)
  end
end  
