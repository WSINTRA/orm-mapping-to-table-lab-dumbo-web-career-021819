class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name,grade, id=nil)
  	@name = name
  	@grade = grade
  	@id = id
  end

def self.create_table
	sql = <<-SQL
	CREATE TABLE IF NOT EXISTS students (
	id INTEGER PRIMARY KEY,
	name TEXT,
	grade TEXT
	)
	SQL
	DB[:conn].execute(sql)
end


  def self.drop_table
  	sql = <<-SQL
  	DROP TABLE students
  	SQL
  	DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
	INSERT INTO students (name,grade)	
	VALUES (?,?)
	SQL
	DB[:conn].execute(sql,self.name,self.grade)
	#However, at the end of your #save method, 
#you need to grab the ID of the last inserted row, i.e. 
#and assign 
#it to the be the value of the @id attribute of the given instance.
    id = <<-SQL
    SELECT id
    FROM students
    ORDER BY id 
    DESC limit 1
    SQL
    value = DB[:conn].execute(id)
    @id = value[0][0]
   
  end

def self.create(name:, grade:)
	student = Student.new(name, grade)
	student.save
	student
end

  
end
