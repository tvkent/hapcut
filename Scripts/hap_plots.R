library(data.table)
library(magrittr)
library(dplyr)
library(ggplot2)
library(wesanderson)

setwd('~/hapcut/Results')

grand <- c(wes_palette("GrandBudapest")[3],wes_palette("GrandBudapest")[2])

cg100 <- fread('100_hapcut.parsed.txt') 
cg101 <- fread('101_hapcut.parsed.txt')
cg102 <- fread('102_hapcut.parsed.txt')
cg107 <- fread('107_hapcut.parsed.txt')
cg196 <- fread('196_hapcut.parsed.txt')
cg27 <- fread('27_hapcut.parsed.txt')
cg28 <- fread('28_hapcut.parsed.txt')
cg87 <- fread('87_hapcut.parsed.txt')

cg100.FT <- cg100 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
cg101.FT <- cg101 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
cg102.FT <- cg102 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
cg107.FT <- cg107 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
cg196.FT <- cg196 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
cg27.FT <- cg27 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
cg28.FT <- cg28 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
cg87.FT <- cg87 %>% filter(chr=='scaffold_2', last>7539046, first<7541032)
all.FT <- all %>% filter(chr=='scaffold_2', last>7539046, first<7541032)

all <- rbind(cg100, cg101, cg102, cg107, cg196, cg27, cg28, cg87)

#plot span by minsum
pdf('haps.pdf',width=8, height=5)
cg100 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '100') + geom_point(data = cg100.FT, inherit.aes=TRUE, color=grand[2])
cg101 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '101') + geom_point(data = cg101.FT, inherit.aes=TRUE, color=grand[2])
cg102 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '102') + geom_point(data = cg102.FT, inherit.aes=TRUE, color=grand[2])
cg107 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '107') + geom_point(data = cg107.FT, inherit.aes=TRUE, color=grand[2])
cg196 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '196') + geom_point(data = cg196.FT, inherit.aes=TRUE, color=grand[2])
cg27 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '27') + geom_point(data = cg27.FT, inherit.aes=TRUE, color=grand[2])
cg28 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '28') + geom_point(data = cg28.FT, inherit.aes=TRUE, color=grand[2])
cg87 %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '87') + geom_point(data = cg87.FT, inherit.aes=TRUE, color=grand[2])
all %>% ggplot(aes(x=span, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = 'All') + geom_point(data = all.FT, inherit.aes=TRUE, color=grand[2])
dev.off()

#plot SNPs by minsum
pdf('haps_snps.pdf',width=8, height=5)
cg100 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '100') + geom_point(data = cg100.FT, inherit.aes=TRUE, color=grand[2])
cg101 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '101') + geom_point(data = cg101.FT, inherit.aes=TRUE, color=grand[2])
cg102 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '102') + geom_point(data = cg102.FT, inherit.aes=TRUE, color=grand[2])
cg107 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '107') + geom_point(data = cg107.FT, inherit.aes=TRUE, color=grand[2])
cg196 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '196') + geom_point(data = cg196.FT, inherit.aes=TRUE, color=grand[2])
cg27 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '27') + geom_point(data = cg27.FT, inherit.aes=TRUE, color=grand[2])
cg28 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '28') + geom_point(data = cg28.FT, inherit.aes=TRUE, color=grand[2])
cg87 %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = '87') + geom_point(data = cg87.FT, inherit.aes=TRUE, color=grand[2])
all %>% ggplot(aes(x=phased, y=minsum)) + geom_point() + geom_smooth(method='lm', se = TRUE, color = grand[1]) +
  ggtitle(label = 'All') + geom_point(data = all.FT, inherit.aes=TRUE, color=grand[2])
dev.off()