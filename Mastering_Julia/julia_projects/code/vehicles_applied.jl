#
# vehicles_applied.jl
#

using Vehicles;

malcolm = Contact("Малколм","mal@abc.net","+44 7777 555999");
myCar = Ford(malcolm, "Model T", 1000, 50.0);
myBike = Scooter(malcolm, "Vespa", 125, 35.0);

james = Contact("Джеймс","jim@abc.net","+44 7777666888");
jmCar = BMW(james,"Series 500", 3200, 125.0);
jmCar.color = "черный";
jmBoat = Yacht(james,"Oceanis 44",14.6);
jmBike = MotorBike(james, "Harley", 850, 120.0);

david = Contact("Дэвид","dave@abc.net","+30 7777 222444");
dvCar = VW(david,"Golf", "дизель", "красный", 1800, 85.0);
dvBoat = Speedboat(david,"Sealine 28","бензин", 600, 45.0, 8.2); 

#-----------------------

dsBoat.owner

msCar
msCar.owner = david;
msCar

s = [myCar, jmCar, dvCar]

 
for c in s
    who = c.owner.name
    model = c.make
    println("$who имеет автомашину $model")
end
        
s =[jmCar, jmBike, jmBoat]  
for c in s
    who = c.owner.name
    model = c.make
    println("$who имеет транспортное средство $model")
end

print "Джеймс владеет следующими траспортными средствами: "

for c in s
    print("$(s.make) ")
end

println()
