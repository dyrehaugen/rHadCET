# ~/zr/clim/HadCET/plotly.r
# 220105 001
# ref mailutveksling med Arve
#
# https://cengel.github.io/R-data-viz/interactive-graphs.html#plotly
# https://stackoverflow.com/questions/44048347/r-open-plotly-in-standalone-window

library("ggplot2")
library("plotly")

print_app <- function(widget) {

  # Generate random file name
  # temp <- paste(tempfile('plotly'), 'html', sep = '.')
  temp = "/home/jmh/zr/clim/jmh/HadCET/plotly.html"  

  # Save. Note, leaving selfcontained=TRUE created files that froze my browser
  #  htmlwidgets::saveWidget(widget, temp, selfcontained = FALSE)
    htmlwidgets::saveWidget(widget, temp, selfcontained = TRUE)  # jmh: Works!  

  # Launch with desired application
  # system(sprintf("firefox -app=file://%s", temp))  
  # system("firefox file:///home/jmh/zr/clim/jmh/HadCET/plotly.html")
  system(sprintf("firefox file://%s", temp))  
    
  # Return file name if it's needed for any other purpose
  temp
}

cet.raw=read.csv("HadCET.csv", sep="", skip=6, header=TRUE)
year=as.numeric(row.names(cet.raw))  # NB for ggplotting
temp=as.numeric(cet.raw$YEAR)
df=data.frame(year,temp)

# p=ggplot(data=df, aes(x=year, y=temp)) + geom_point()
p=ggplot(data=df, aes(x=year, y=temp, group=1))+geom_point(color="red")+geom_line(color="grey")+scale_x_continuous(breaks=seq(1660,2020,10))+scale_y_continuous(breaks=seq(7,11,0.5))+ggtitle("HadCET Yearly Average Temperature 1659 - 2021")+theme(plot.title=element_text(hjust=0.5))
p2=ggplotly(p)
print_app(p2)

# 
# Adding Lines

