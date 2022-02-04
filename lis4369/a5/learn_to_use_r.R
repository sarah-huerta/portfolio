head(mtcars)

head(mtcars, m=3)


names(mtcars)

mtcars$mpg

plot(mtcars$disp, mtcars$mpg)

cylcount <- table(mtcars$cyl)

boxplot(mtcars$mpg)


hist(mtcars$mpg, breaks = 6)

barplot(BOD$demand, col=rainbow(6))

testscores <- c(96, 71, 85, 92, 82, 78, 72, 81, 68, 61, 78, 86, 90)

barplot(testscores)

testcolors <- ifelse(testscores >=80, "blue", "red")

barplot(testscores, col=testcolors, main="Test scores", ylim=c(0,100), las=1)

qplot(disp, mpg, data=mtcars)
