require("pry")
require("doctor")

class Patient
  attr_reader :name, :birth, :id, :doctor_id

  def initialize(attributes)
   @name = attributes[:name]
   @birth = attributes[:birth]
   DB.exec("INSERT INTO patients (name, birth) VALUES ('#{@name}', '#{@birth}')")
   result = DB.exec("SELECT id FROM patients WHERE name='#{@name}'")
   @id = result[0].fetch("id").to_i
 end
end
