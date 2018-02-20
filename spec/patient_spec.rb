 require 'rspec'
require 'pg'
require 'pry'
require 'patient'

DB = PG.connect({:dbname => 'clinic_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
  end
end

describe('Patient') do
  describe('#initialize') do
    it('creates new patient instance') do
      patient = Patient.new({:name =>'russell', :birth => '1995-10-23'})
      expect(patient.name).to(eq('russell'))
      expect(patient.birth).to(eq('1995-10-23'))
    end
    describe('#set_doctor') do
    it('set doctor and update database') do
      doctor = Doctor.new({:name =>'rodger', :specialty => 'backs'})
      patient = Patient.new({:name =>'russell', :birth => '1995-10-23'})
      patient.set_doctor(doctor)
      expect(patient.doctor_id).to(eq(doctor.id))
    end
  end
end

  # describe('#==') do
  #   it('returns true if card fronts are the same') do
  #     card1 = Card.new({:front =>'term', :back => 'definition'})
  #     card2 = Card.new({:front =>'term', :back => 'definition'})
  #     expect(card1==card2).to(eq(true))
  #   end
  # end
  #
  # describe('#create') do
  #   it('creates card to database') do
  #     card1 = Card.new({:front =>'front1', :back => 'back1'})
  #     card2 = Card.new({:front =>'front2', :back => 'back2'})
  #     card1.create
  #     card1.create
  #     expect(Card.read_all.include?(card1)).to(eq(true));
  #     expect(Card.read_all.include?(card2)).to(eq(false));
  #   end
  # end
  #
  # describe('#remove_all') do
  #   it('removes all rows from card table') do
  #     card1 = Card.new({:front =>'front1', :back => 'back1'})
  #     card1.create
  #     Card.remove_all
  #     expect(Card.read_all).to(eq([]))
  #   end
  # end
  #
  # describe('#update') do
  #   it('updates card in cards table') do
  #     card1 = Card.new({:front =>'front1', :back => 'back1'})
  #     card1.create
  #     card1.front = 'new front'
  #     card1.back = 'new back'
  #     expect(Card.read_all.include?(card1)).to(eq(false))
  #     card1.update
  #     expect(Card.read_all.include?(card1)).to(eq(true))
  #   end
  # end
  #
  # describe('#remove') do
  #   it('removes card data from table') do
  #     card1 = Card.new({:front =>'front1', :back => 'back1'})
  #     card1.create
  #     card1.remove
  #     expect(Card.read_all).to(eq([]))
  #   end
  # end
end
