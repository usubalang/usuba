library(ggplot2)
library(reshape2)
bench = read.table("~/Workspace/usuba/bench/eval/des-std/data2.dat")
melted = melt(bench)
ggplot(melted,aes(reorder(V1,value),value, fill=variable)) + 
  geom_bar(position = "stack",stat = "identity") +
  geom_text(aes(label=value), position=position_stack(), vjust=-0.5) +
  theme_set(theme_gray(base_size = 18)) +
  xlab("Implementation") +
  ylab("Throughput (MiB/s)") +
  scale_fill_discrete(labels=c("DES","orthogonalization")) +
  theme(legend.justification=c(0,1), legend.position=c(0.02,0.98)) +
  theme(legend.title=element_blank()) 
  
ggsave("/home/dada/Workspace/usuba/bench/eval/des-std/speed_std2.pdf", plot = last_plot(),
       device = "pdf")