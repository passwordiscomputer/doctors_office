require("pry")


class Patient
  attr_reader :name, :birth, :id, :doctor_id

  def initialize(attributes)
   @name = attributes[:name]
   @birth = attributes[:birth]
   @id = attributes[:id]
   @doctor_id = attributes[:doctor_id]
 end

 def self.read_all
   returned_patients = DB.exec("SELECT * FROM patients;")
   patients = []
   returned_patients.each() do |patient|
     name = patient.fetch("name")
     birth = patient.fetch("birth")
     id = patient.fetch("id").to_i
     doctor_id = patient.fetch("doctor_id").to_i
     patients.push(Patient.new({:name => name, :birth => birth, :id => id, :doctor_id => doctor_id}))
   end
   return patients
 end

  def ==(other_patient)
   @id == other_patient.id
  end

  def set_patients(doctor_id)
    @doctor_id = doctor_id
   DB.exec("UPDATE patients SET doctor_id = #{@doctor_id} WHERE id = #{@id}")
  end

  def self.remove_all
   DB.exec("DELETE FROM patients *;")
  end

  def create
    @id = DB.exec("INSERT INTO patients (name, birth, doctor_id) VALUES ('#{@name}', '#{@birth}', #{@doctor_id}) RETURNING id;")[0]["id"]
  end

  def self.remove_all
  DB.exec("DELETE FROM patients *;")
  end

  def update
  DB.exec("UPDATE patients SET name = '#{@name}', birth = '#{@birth}' WHERE id=#{@id};")
  end

  def self.find(id)
    Patient.read_all().each() do |patient|
      if patient.id().==(id)
        return patient
      end
    end
    nil
  end

end
