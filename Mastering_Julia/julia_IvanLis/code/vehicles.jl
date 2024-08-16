#
# vehicles.jl
#

module Vehicles

export Contact, Vehicle, Car, Bike, Yacht, Powerboat, Boat
export Ford, BMW, VW, Scooter, MotorBike, Speedboat 


#type Contact
#  name  :: AbstractString 
#  email :: AbstractString 
#  phone :: AbstractString 
#end

type Contact
  name  :: AbstractString 
  email :: AbstractString 
  phone :: AbstractString 

  function Contact(name::AbstractString, email::AbstractString, phone::AbstractString)
    length(name)  == 0 && error("Отсутствует имя контактного лица")
    length(email) == 0 && length(phone) == 0 && error("Отсутствует электронная почта либо телефонный номер")
    new(name, email, phone)
  end    
end
                             
   
abstract Vehicle

abstract Car  <: Vehicle
abstract Bike <: Vehicle
abstract Boat <: Vehicle

abstract Powerboat <: Boat 


type Ford <: Car
  owner     ::Contact
  model     ::AbstractString 
  fuel      ::AbstractString 
  color     ::AbstractString 
  engine_cc ::Int64
  speed_mph ::Float64
    
  function Ford(owner, model, engine_cc,speed_mph)
    new(owner,model,"бензин","черный",engine_cc,speed_mph)
  end
end

type BMW <: Car
  owner::Contact
  model::AbstractString 
  fuel::AbstractString 
  color::AbstractString 
  engine_cc::Int64
  speed_mph::Float64
    
  function BMW(owner,model,engine_cc,speed_mph)
    new (owner,model,"бензин","синий",engine_cc,speed_mph)
  end
end

type VW <: Car
  owner::Contact
  model::AbstractString 
  fuel::AbstractString 
  color::AbstractString 
  engine_cc::Int64
  speed_mph::Float64
end

type MotorBike <: Bike
  owner::Contact
  model::AbstractString 
  engine_cc::Int64
  speed_mph::Float64
end

type Scooter <: Bike
  owner::Contact
  model::AbstractString 
  engine_cc::Int64
  speed_mph::Float64
end

type Yacht <: Boat
  owner::Contact
  model::AbstractString 
  length_m::Float64
end

type Speedboat <: Powerboat
  owner::Contact
  model::AbstractString 
  fuel::AbstractString 
  engine_cc::Int64
  speed_knots::Float64
  length_m::Float64
end



function isquicker(a::VW, b::BMW)
  if (a.speed_mph == b.speed_mph)
    return nothing
  else
    return(a.speed_mph > b.speed_mph ? a : b)
  end
end 

function isquicker(a::Speedboat, b::Scooter)
  const KNOTS_TO_MPH = 1.151
  a_mph = KNOTS_TO_MPH * a.speed_knots
  if (a_mph == b.speed_mph)
    return nothing
  else
    return(a_mph > b.speed_mph ? a : b)
  end
end

function is_longer(a::Yacht, b::Speedboat)
   if (a.length_m == b.length_m) 
       return nothing
    else
       return(a.length > b.length_m ? a : b)
    end
end

is_quicker(a::BMW, b::VW) = is_quicker(b,a)
is_quicker(a::Scooter, b::Speedboat) = is_quicker(b,a)
is_longer(a::Speedboat, b::Yacht) = is_longer(b,a)

end