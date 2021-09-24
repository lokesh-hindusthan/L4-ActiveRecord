require 'active_record'

class Todo < ActiveRecord::Base
  
 def initialize(text, due_date, completed)
     @text=text
     @due_date=due_date
     @completed=completed
 end
  
 def to_displayable_string
    display_status = "[#{@completed ? "X" : " "}]"
    display_date = @due_date unless (@due_date ==Date.today)
    "#{id} #{display_status} #{@text} #{display_date}"
 end
    attr_accessor :text
    attr_accessor :due_date
    attr_accessor :completed
  
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
    puts "my todolist \n"
    puts "Overdue\n"
    message_display = Todo.where("due_date < ?",Date.today).map { |todo| todo.to_displayable_string }
    puts message_display
    
    puts "\nDue Today\n"
    message_display = Todo.where("due_date = ?",Date.today).map { |todo| todo.to_displayable_string }
    puts message_display

    puts "\nDue Later\n"
    message_display = Todo.where("due_date > ?",Date.today).map { |todo| todo.to_displayable_string }
    puts message_display
  end

  def self.add_task(todo1)
    Todo.create!(text: todo1[:text], due_date: Date.today + todo1[:due_in_days], completed: false)
  end

  def self.mark_as_complete(todo_id)
  update(todo_id, completed: true)
  end
end

  

  
 
