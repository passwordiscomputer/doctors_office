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

  def ==(other_patient)
   @id == other_patient.id
  end

  def set_doctor(doctor)
   @doctor_id = doctor.id
   DB.exec("UPDATE patients SET doctor_id = #{@doctor_id} WHERE id = #{@id}")
  end

  def self.remove_all
   DB.exec("DELETE FROM patients *;")
  end

end
