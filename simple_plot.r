# one can run this script with Rscript simple_plot.r from the command line
# it seems to create an Rplots.pdf file that contains the resulting visualization
library(txtplot)
nums = c(1,2,3)
doubled_nums <- nums * 2
plot(nums,doubled_nums)
txtplot(nums,doubled_nums)
print(sum(doubled_nums))
