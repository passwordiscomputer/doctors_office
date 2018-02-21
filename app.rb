require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload('./lib/**/*.rb')
require './lib/doctor'
require './lib/patient'
require 'pg'

DB = PG.connect({:dbname => 'clinic'})
Doctor.remove_all
Patient.remove_all

get('/') do
  @doctors = Doctor.read_all
  erb(:home)
end


post('/doctors') do
  doctor = Doctor.new(params)
  doctor.create
  @doctors = Doctor.read_all()
  erb(:doctors)
end

post('/patients') do
  name = params.fetch("name")
  birth = params.fetch("birth")
  doctor_id = params.fetch("doctor_id").to_i
  patient = Patient.new({:name => name, :birth => birth, :id => nil, :doctor_id => doctor_id})
  patient.create

  @patients = Patient.read_all()
  erb(:patients)
end

get('/patients') do

end

get('/patients/:id') do
  @patient = Patient.find(params[:id].to_i)
  @doctor = Doctor.find(@patient.doctor_id)

  erb(:patient)
end

get('/doctors/:id') do
  @doctor= Doctor.find(params[:id].to_i)
  @patients = @doctor.patients
  erb(:doctor)
end


#
# get('/:word') do
#
# end
#
# post('/:word') do
#
# end
