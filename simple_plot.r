# one can run this script with Rscript simple_plot.r from the command line
# it seems to create an Rplots.pdf file that contains the resulting visualization
library(txtplot)
library(modules)

# import a local module and use one of its member functions
# (see hello_module.R in this same directory)
myModule <- modules::use("hello_module.R")
myModule$shout()

nums = c(1,2,3)
doubled_nums <- nums * 2
plot(nums,doubled_nums)
txtplot(nums,doubled_nums)
print(sum(doubled_nums))
