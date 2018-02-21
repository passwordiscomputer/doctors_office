require("pry")

class Doctor
  attr_reader :name, :specialty, :id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty = attributes[:specialty]
    @id = attributes[:id]
  end

  def self.read_all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty")
      id = doctor.fetch("id").to_i

      doctors.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
    end
    return doctors
  end

  def ==(other_doctor)
    @id == other_doctor.id
  end

  def patients
    patients_list = []
    patients = DB.exec("SELECT * FROM patients WHERE  doctor_id = #{@id};")
    patients.each() do |patient|
      name = patient.fetch("name")
      birth = patient.fetch("birth")
      id = patient.fetch("id").to_i
      doctor_id = patient.fetch("doctor_id").to_i
      patients_list.push(Patient.new({:name => name, :birth => birth, :id => id, :doctor_id => doctor_id}))
    end
    patients_list
  end

  def create
    DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}');")
    result = DB.exec("SELECT id FROM doctors WHERE name = '#{@name}' AND specialty = '#{@specialty}';")
    @id = result[0].fetch('id').to_i
  end

  def self.remove_all
  DB.exec("DELETE FROM doctors *;")
  end

  def update
  DB.exec("UPDATE doctors SET name = '#{@name}', specialty = '#{@specialty}' WHERE id=#{@id};")
  end

  def self.find(id)
    Doctor.read_all().each() do |doctor|
      if doctor.id().==(id)
        return doctor
      end
      nil
    end
  end

end


#   def self.remove_all
#     DB.exec("DELETE FROM cards *;")
#   end
#
#   def ==(other_card)
#     (@front == other_card.front) && (@back == other_card.back)
#   end

#   def update
#     DB.exec("UPDATE cards SET front = '#{@front}', back = '#{@back}' WHERE id=#{@id};")
#   end
#
#   def remove
#     DB.exec("DELETE FROM cards WHERE id=#{@id};")
#   end
# end
