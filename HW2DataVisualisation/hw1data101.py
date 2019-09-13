import random

summedUp = 0
counter = 1
for i in range(100):
    randomInt = random.randint(1, 100)
    print "Random Int", counter,":", randomInt
    counter = counter + 1
    summedUp = summedUp + randomInt

print "Total Sum:", summedUp
