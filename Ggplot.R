library(ggplot2)
library(viridis)

# Ripped from the pages of ggplot2
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(size = 4, aes(colour = factor(cyl))) +
  scale_color_viridis(discrete = TRUE) +
  theme_bw()

# Ripped from the pages of ggplot2
dsub <- subset(diamonds, x > 5 & x < 6 & y > 5 & y < 6)
dsub$diff <- with(dsub, sqrt(abs(x - y)) * sign(x - y))
d <- ggplot(dsub, aes(x, y, colour = diff)) + geom_point()
d + scale_color_viridis() + theme_bw()


# From the main viridis example
dat <- data.frame(x = rnorm(10000), y = rnorm(10000))

ggplot(dat, aes(x = x, y = y)) +
  geom_hex() + coord_fixed() +
  scale_fill_viridis() + theme_bw()


library(ggplot2)
library(MASS)
library(gridExtra)

data("geyser", package="MASS")

ggplot(geyser, aes(x = duration, y = waiting)) +
  xlim(0.5, 6) + ylim(40, 110) +
  stat_density2d(aes(fill = ..level..), geom = "polygon") +
  theme_bw() +
  theme(panel.grid = element_blank()) -> gg

grid.arrange(
  gg + scale_fill_viridis(option = "A") + labs(x = "Viridis A", y = NULL),
  gg + scale_fill_viridis(option = "B") + labs(x = "Viridis B", y = NULL),
  gg + scale_fill_viridis(option = "C") + labs(x = "Viridis C", y = NULL),
  gg + scale_fill_viridis(option = "D") + labs(x = "Viridis D", y = NULL),
  gg + scale_fill_viridis(option = "E") + labs(x = "Viridis E", y = NULL),
  gg + scale_fill_viridis(option = "F") + labs(x = "Viridis F", y = NULL),
  gg + scale_fill_viridis(option = "G") + labs(x = "Viridis G", y = NULL),
  gg + scale_fill_viridis(option = "H") + labs(x = "Viridis H", y = NULL),
  ncol = 4, nrow = 2
)



library(dplyr)
library(ggplot2)
theme_set(theme_bw(base_size = 16))

data_url = 'http://bit.ly/2cLzoxH'
gapminder = read.csv(data_url)

gapminder %>% 
  ggplot(aes(x=lifeExp,y=gdpPercap)) + 
  geom_point(alpha=0.3)  

# filter dataframe to get data to be highligheted
highlight_df <- gapminder %>% 
  filter(gdpPercap>=59000)

gapminder %>% 
  ggplot(aes(x=lifeExp,y=gdpPercap)) + 
  geom_point(alpha=0.3) +
  geom_point(data=highlight_df, 
             aes(x=lifeExp,y=gdpPercap), 
             color='red',
             size=3)