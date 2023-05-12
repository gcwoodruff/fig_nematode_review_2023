#the goal is to label a ficus phylogeny with worm occupancy

library(treeio)
library(ape)
library(RRphylo)
library(ggtree)
library(phytools)
library(reshape2)

#set your working directory
setwd("/Users/gavin/genome/fig_worm_papers_meta_2022/publication_preparation/figure_2")

#tree from paper Zhang et al. 2019 "Estimating divergence times and ancestral breeding systems in Ficus and Moraceae "
# https://academic.oup.com/aob/article/123/1/191/5092035
ficus_tree <- read.nexus("Zhang_et_al_2019.txt")

#nematode association data constructed from literature search, see "how_to_be_a_fig_nematode_supplemental_tables.xlsx" & "worm_association_data_iii.csv"

newnema3 <- read.table("worm_association_data_iii.csv", header=TRUE,sep="\t",stringsAsFactors=TRUE)

#remove a bunch of non-Ficus tips from this tree
tips_to_remove <- c("Dryas_octopetala_Rosaceae","Prunus_persica_Rosaceae","Spiraea_cantoniensis_Rosaceae","Ampelocera_hottleyi_Ulmaceae","Ulmus_davidiana_Ulmaceae","Zelkova_schneideriana_Ulmaceae","Zelkova_serrata_Ulmaceae","Aphananthe_aspera_Cannabaceae","Cannabis_sativa_Cannabaceae","Humulus_lupulus_Cannabaceae","Celtis_tetrandra_Cannabaceae","Celtis_philippensis_Cannabaceae","Streblus_smithii_Moreae_Moraceae","Maclura_pomifera_Maclureae_Moraceae","Maclura_cochinchinensis_Maclureae_Moraceae","Maclura_tricuspidata_Maclureae_Moraceae","Broussonetia_papyrifera_Dorstenieae_Moraceae","Malaisia_scandens_Dorstenieae_Moraceae","Trilepisium_madagascariense_Dorstenieae_Moraceae","Trymatococcus_oligandrus_Dorstenieae_Moraceae","Trymatococcus_amazonicus_Dorstenieae_Moraceae","Brosimum_rubescens_Dorstenieae_Moraceae","Helianthostylis_sprucei_Dorstenieae_Moraceae","Brosimum_utile_Dorstenieae_Moraceae","Brosimum_guianense_Dorstenieae_Moraceae","Brosimum_alicastrum_Dorstenieae_Moraceae","Brosimum_lactescens_Dorstenieae_Moraceae","Treculia_africana_Artocarpeae_Moraceae","Treculia_obovoidea_Artocarpeae_Moraceae","Dorstenia_choconiana_Dorstenieae_Moraceae","Dorstenia_arifolia_Dorstenieae_Moraceae","Dorstenia_mannii_Dorstenieae_Moraceae","Utsetela_neglecta_Dorstenieae_Moraceae","Sloetia_elongata_Dorstenieae_Moraceae","Bleekrodea_madagascariensis_Dorstenieae_Moraceae","Fatoua_villosa_Dorstenieae_Moraceae","Pseudolmedia_laevigata_Castilleae_Moraceae","Pseudolmedia_laevis_Castilleae_Moraceae","Pseudolmedia_macrophylla_Castilleae_Moraceae","Pseudolmedia_spuria_Castilleae_Moraceae","Perebea_angustifolia_Castilleae_Moraceae","Perebea_humilis_Castilleae_Moraceae","Perebea_guianensis_Castilleae_Moraceae","Poulsenia_armata_Castilleae_Moraceae","Antiaropsis_decipiens_Castilleae_Moraceae","Sparattosyce_dioica_Castilleae_Moraceae","Mesogyne_insignis_Castilleae_Moraceae","Antiaris_toxicaria_Castilleae_Moraceae","Maquira_calophylla_Castilleae_Moraceae","Naucleopsis_ulei_Castilleae_Moraceae","Naucleopsis_krukovii_Castilleae_Moraceae","Castilla_elastica_Castilleae_Moraceae","Castilla_ulei_Castilleae_Moraceae","Maquira_costaricana_Castilleae_Moraceae","Perebea_mollis_Castilleae_Moraceae","Perebea_xanthochyma_Castilleae_Moraceae","Helicostylis_tomentosa_Castilleae_Moraceae","Naucleopsis_ternstroemiiflora_Castilleae_Moraceae","Naucleopsis_caloneura_Castilleae_Moraceae","Naucleopsis_naga_Castilleae_Moraceae","Naucleopsis_guianensis_Castilleae_Morraceae","Ficus_tonduzii_Pharmacosycea_Pharmacosycea","Batocarpus_amazonicus_Artocarpeae_Moraceae","Clarisia_biflora_Artocarpeae_Moraceae","Clarisia_ilicifolia_Artocarpeae_Moraceae","Batocarpus_costaricensis_Artocarpeae_Moraceae","Prainea_limpato_Artocarpeae_Moraceae","Parartocarpus_venenosus_Artocarpeae_Moraceae","Artocarpus_heterophyllus_Artocarpeae_Moraceae","Artocarpus_altilis_Artocarpeae_Moraceae","Artocarpus_lakoocha_Artocarpeae_Moraceae","Bagassa_guianensis_Moreae_Moraceae","Milicia_excelsa_Moreae_Moraceae","Streblus_pendulinus_Moreae_Moraceae","Streblus_glaber_Moreae_Moraceae","Sorocea_bonplandii_Moreae_Moraceae","Sorocea_pubivena_Moreae_Moraceae","Sorocea_affinis_Moreae_Moraceae","Sorocea_briquetii_Moreae_Moraceae","Trophis_racemosa_Moreae_Moraceae","Trophis_involucrata_Moreae_Moraceae","Morus_alba_Moreae_Moraceae","Morus_indica_Moreae_Moraceae","Morus_nigra_Moreae_Moraceae","Urtica_dioica_Urticaceae","Lecanthus_peduncularis_Urticaceae","Pilea_cadierei_Urticaceae","Pilea_sinofasciata_Urticaceae","Pilea_insolens_Urticaceae","Pilea_melastomoides_Urticaceae","Debregeasia_longifolia_Urticaceae","Boehmeria_densiflora_Urticaceae","Boehmeria_spicata_Urticaceae","Boehmeria_umbrosa_Urticaceae","Coussapoa_nymphaeifolia_Urticaceae","Coussapoa_villosa_Urticaceae","Coussapoa_schottii_Urticaceae","Coussapoa_latifolia_Urticaceae","Coussapoa_panamensis_Urticaceae","Cecropia_peltata_Urticaceae","Cecropia_obtusifolia_Urticaceae","Cecropia_palmata_Urticaceae","Cecropia_insignis_Urticaceae","Barbeya_oleoides_Barbeyaceae","Dirachma_socotrana_Dirachmaceae","Rhamnus_utilis_Rhamnaceae","Rhamnus_cathartica_Rhamnaceae","Rhamnus_lycioides_Rhamnaceae","Sarcomphalus_obtusifolius_Rhamnaceae","Ceanothus_pumilus_Rhamnaceae","Ceanothus_sanguineus_Rhamnaceae","Paliurus_spina_christi_Rhamnaceae","Hovenia_dulcis_Rhamnaceae","Gouania_mauritiana_Rhamnaceae","Shepherdia_canadensis_Elaeagnaceae","Hippophae_rhamnoidesElaeagnaceae","Elaeagnus_angustifolia_Elaeagnaceae","Elaeagnus_bockii_Elaeagnaceae","Elaeagnus_umbellata_Elaeagnaceae")

ficus_tree_b <- drop.tip(ficus_tree, tips_to_remove)


#get factor levels right
newnema3$Nematode_clade <- factor(newnema3$Nematode_clade, levels=c("Clade IV", "Clade V", "Both", "Unknown"))


ggtree(ficus_tree_b, size=0.45, branch.length='none', layout='circular') %<+% newnema3 + geom_tippoint(aes(color = Nematode_clade)) + scale_colour_manual(values=c("#0F6292","#FFED00","#16FF00","#000000")) + geom_cladelab(node=214, label="Urostigma 2", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=346, label="Sycomorous", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=299, label="Sycidium", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=325, label="Synoecia", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=205, label="Pharmacosycea 1", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=397, label="Pharmacosycea 2", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=340, label="Urostigma 1", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=333, label="Ficus", align=TRUE,  offset = .2, textcolor='black', barcolor='black') + geom_cladelab(node=320, label="Ficus", align=TRUE,  offset = .2, textcolor='black', barcolor='black') 

#ggsave("ficus_worm_phylogeny_2.pdf")

#figure was cleaned up in illustrator
