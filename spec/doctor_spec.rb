require 'rspec'
require 'pg'
require 'pry'
require 'doctor'

DB = PG.connect({:dbname => 'clinic_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

describe('Doctor') do
  describe('#initialize') do
    it('creates new doctor instance') do
      doctor = Doctor.new({:name =>'rodger', :specialty => 'backs'})
      expect(doctor.name).to(eq('rodger'))
      expect(doctor.specialty).to(eq('backs'))
    end
    describe('#read_all') do
    it('select all doctor instances from database') do
      doctor = Doctor.new({:name =>'rodger', :specialty => 'backs'})
      expect(Doctor.read_all.include?(doctor)).to(eq(true))
    end
    describe('#create') do
      it('creates doctor to database') do
        doctor = Doctor.new({:name =>'rodger', :specialty => 'backs'})
        doctor.create
        expect(Doctor.read_all.include?(doctor)).to(eq(true));
      end
    end
  end
  describe('#remove_all') do
    it('removes all rows from doctors table') do
      doctor = Doctor.new({:name =>'rodger', :specialty => 'backs'})
      doctor.create
      Doctor.remove_all
      expect(Doctor.read_all).to(eq([]))
    end
  end
  describe('#update') do
    it('updates doctor in doctors table') do
      doctor = Doctor.new({:name => 'rodger', :specialty => 'backs'})
      doctor.create
      name = 'new name'
      specialty = 'new specialty'
      expect(Doctor.read_all.include?(doctor)).to(eq(true))
      doctor.update
      expect(Doctor.read_all.include?(doctor)).to(eq(false))
    end
  end
  describe(".find") do
    it("returns a list by its ID") do
      doctor = Doctor.new({:name => 'rodger', :specialty => 'backs'})
      doctor.create
      expect(Doctor.find(doctor.id())).to(eq(doctor))
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
