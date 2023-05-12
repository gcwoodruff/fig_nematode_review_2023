#the goal is to map Ficus association on nematode phylogeny

#big nematode trees from supplemental materials in Ahmed et al. 
#"Phylogenomic Analysis of the Phylum Nematoda: Conflicts and Congruences With Morphology, 
#18S rRNA, and Mitogenomes" Frontiers in Ecology and Evolution 2022
#https://www.frontiersin.org/articles/10.3389/fevo.2021.769565/full
#https://figshare.com/s/946b2bc6aef7ce4a9e6a
#Ahmed_Tylenchina_IQTREE_Fullname_output.treefile
#Ahmed_Rhabditina_IQTREE_Fullname_output.treefile
#Ahmed_nematoda_IQTREE_PMFS_Fullname_output.treefile

#Fig aphelenchid sequences from accessions derived from Kanzaki et al. 
#"New plant-parasitic nematode from the mostly mycophagous genus Bursaphelenchus discovered inside figs in Japan." 
#PLoS One 2014
#https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0099241
#Table S2 ; these sequences were retreived, aligned with mafft, trimmed with trimal, 
#and a tree was made with fasttree.

#Diplogastrid tree from Susoy et al. 2015 "Rapid diversification associated with a macroevolutionary pulse of developmental plasticity" eLife 2015
#https://elifesciences.org/articles/5463
#http://www.pristionchus.org/download/Susoy-suppl_data.txt

#these three trees were combined & pruned to make "nema_combined_15.nwk." DO NOT TRUST THE BRANCH LENGTHS ON THIS because it is a chimeric tree generated from different datasets. The topology should be consistent with the studies above. Please reach out if you want more details.

#-- Gavin Woodruff (gcwoodruff@ou.edu)

#load packages
library(treeio)
library(ape)
library(RRphylo)
library(ggtree)
library(phytools)

#set working directory
setwd("/Users/gavin/genome/fig_worm_papers_meta_2022/publication_preparation/figure_4/")


#get tree in there!
nema_combined_15 <- read.tree("nema_combined_15.nwk")


#get fig association data in there!
dat <- read.table("fig_association_data.csv", sep="\t", header=TRUE)




ggtree(nema_combined_15, size=0.45, branch.length='none', layout='circular') %<+% dat  + geom_hilight(node=c(332,337,341,35,454), fill='#006d2c', type="rect") + geom_hilight(node=c(346,400,427,436), fill='#41ab5d', type="rect") + geom_hilight(node=c(422), fill='#c7e9c0', type="rect") + geom_tippoint(aes(colour = fig_associated), size=0.5) + scale_colour_manual(values = c("white", "#006d2c")) +theme(legend.position="none") + geom_cladelab(node=486, label="Enoplia", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=478, label="Dorylaimia", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=263, label="Spirurina", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=278, label="Tylenchina", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=363, label="Rhabditina", align=TRUE,  offset = .4, textcolor='black', barcolor='black')  + geom_cladelab(node=405, label="Diplogastridae", align=TRUE,  offset = .2, textcolor='black', barcolor='black') 


#figure was cleaned up (and light green clades changed to yellow) in illustrator





