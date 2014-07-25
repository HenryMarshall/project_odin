hamlet = open("hamlet.txt").read
puts hamlet.scan(/(Ham\..*(?:\n\s{4}.+)*)/)