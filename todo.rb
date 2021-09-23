require 'active_record'

class Todo < ActiveRecord::Base
  
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{display_status} #{todo_text} #{display_date}"
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
    displayable_list = Todo.where("due_date < ?",Date.today).map { |todo| todo.to_displayable_string }
    puts displayable_list
    
    puts "\nDue Today\n"
    displayable_list = Todo.where("due_date = ?",Date.today).map { |todo| todo.to_displayable_string }
    puts displayable_list

    puts "\nDue Later\n"
    displayable_list = Todo.where("due_date > ?",Date.today).map { |todo| todo.to_displayable_string }
    puts displayable_list
  end

  def self.add_task(new_todo)
    Todo.create!(todo_text: new_todo[:todo_text], due_date: Date.today + new_todo[:due_in_days], completed: false).id
  end

  def self.mark_as_complete(todo_id)
    Todo.find(todo_id).update(completed:true)
    Todo.find(todo_id)
  end
end

  

  
 
