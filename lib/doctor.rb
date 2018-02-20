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
end

#   def self.remove_all
#     DB.exec("DELETE FROM cards *;")
#   end
#
#   def ==(other_card)
#     (@front == other_card.front) && (@back == other_card.back)
#   end
#
#   def create
#     already_there = false
#     cards = Card.read_all
#     cards.each do |card|
#       already_there = true if self==card
#     end
#     if !already_there
#       DB.exec("INSERT INTO cards (front, back) VALUES ('#{@front}', '#{@back}');")
#       result = DB.exec("SELECT id FROM cards WHERE front = '#{@front}' AND back = '#{@back}';")
#       @id = result[0].fetch('id').to_i
#     end
#   end
#
#   def update
#     DB.exec("UPDATE cards SET front = '#{@front}', back = '#{@back}' WHERE id=#{@id};")
#   end
#
#   def remove
#     DB.exec("DELETE FROM cards WHERE id=#{@id};")
#   end
# end
