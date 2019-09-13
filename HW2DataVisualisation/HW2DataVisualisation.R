#HW2

library(ggplot)
library(tidyverse)

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "black", size = 5, shape = 19) + geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE, size = 3)

#1st in 1st Column

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, group = drv), se = FALSE, size = 3) + geom_point(mapping = aes(x = displ, y = hwy), color = "black", size = 5, shape = 19)

#1st in 2ndColumn

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = drv), size = 5, shape = 19) + geom_smooth(mapping = aes(x = displ, y = hwy, group = drv, color = drv), se = FALSE, size = 3)

#2nd in 1st Column
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = drv), size = 5, shape = 19) + geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE, size = 3)

#2nd in 2nd Column

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = drv), size = 5, shape = 19) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), se = FALSE, size = 3)

#3rd in 1st Column

ggplot(data = mpg,mapping = aes(x = displ, y = hwy, fill = drv)) + geom_point(shape = 21,colour = "white", stroke = 3,size = 5)

#3rd  in 2nd Column