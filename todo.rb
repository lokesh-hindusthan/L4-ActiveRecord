require 'active_record'

class Todo < ActiveRecord::Base
  
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id} #{display_status} #{todo_text} #{display_date}"
  end
  
   def self.to_displayable_list
    all.map {|todo| todo.to_displayable_string }
   end
  
  def due_today?
    due_date == Date.today
  end
  
   def overdue?
    due_date < Date.today
  end

  def due_later?
    due_date > Date.today
  end

 def self.show_list
    puts "Overdue\n"
    message_display = Todo.where("due_date < ?",Date.today).map { |todo| todo.to_displayable_string }
    puts message_display
    
    puts "\nDue Today\n"
    message_displayt = Todo.where("due_date = ?",Date.today).map { |todo| todo.to_displayable_string }
    puts message_display

    puts "\nDue Later\n"
    message_display = Todo.where("due_date > ?",Date.today).map { |todo| todo.to_displayable_string }
    puts message_display
  end

  def self.add_task(todo1)
    Todo.create!(todo_text: todo1[:todo_text], due_date: Date.today + todo1[:due_in_days], completed: false)
  end

  def self.mark_as_complete(todo_id)
    Todo.find(todo_id).update(completed:true)
    Todo.find(todo_id)
  end
end

  

  
 
