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
    "#{id}.  #{display_status} #{@text} #{display_date}"
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
    puts "My todolist \n \n"
    puts "Overdue\n" 
    message_display = Todo.where("due_date < ?",Date.today).map { |todo| todo.to_displayable_list }
    puts message_display
    puts "\n\n"
    
    puts "Due Today\n"
    message_display = Todo.where("due_date = ?",Date.today).map { |todo| todo.to_displayable_list }
    puts message_display
    puts "\n\n"

    puts "Due Later\n"
    message_display = Todo.where("due_date > ?",Date.today).map { |todo| todo.to_displayable_list }
    puts message_display
    puts "\n\n"
  end

  def self.add_task(todo)
    create!(text: todo[:text], due_date: Date.today + todo[:due_in_days])
  end

  def self.mark_as_complete(todo_id)
    update(todo_id, completed: true)
  end
end
