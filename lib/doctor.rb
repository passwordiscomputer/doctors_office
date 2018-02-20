require("pry")

class Doctor
  attr_reader :name, :specialty, :id

  def initialize(attributes)
    @name = attributes[:name]
    @specialty = attributes[:specialty]
    DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}')")
    result = DB.exec("SELECT id FROM doctors WHERE name='#{@name}'")
    @id = result[0].fetch("id").to_i
  end

  def self.read_all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty")
      doctors.push(Doctor.new({:name => name, :specialty => specialty}))
    end
    return doctors
  end

  def ==(other_doctor)
    @id == other_doctor.id
  end

    def create
      already_there = false
      doctor = Doctor.read_all
      doctor.each do |doctor|
        already_there = true if self==doctor
      end
      if !already_there
        DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}');")
        result = DB.exec("SELECT id FROM doctors WHERE name = '#{@name}' AND specialty = '#{@specialty}';")
        @id = result[0].fetch('id').to_i
      end
    end
   def self.remove_all
    DB.exec("DELETE FROM doctors *;")
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
