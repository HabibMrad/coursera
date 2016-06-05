library(Biobase)
library(ALL)
library(hgu95av2.db)

library(ALL)
data(ALL)
ALL

#Q1
edata_5 = exprs(ALL)[,5]
mean(edata_5)

#Q2
library(biomaRt)
mart <- useMart(host='feb2014.archive.ensembl.org', biomart = "ENSEMBL_MART_ENSEMBL")
ensembl <- useDataset("hsapiens_gene_ensembl", mart)
values <- featureNames(ALL)
attrs[grep("affy_hg_u95av2",attrs$name),]
ids1<-getBM(attributes = c("ensembl_gene_id","affy_hg_u95av2","chromosome_name"),filters = "affy_hg_u95av2", values = values, mart = ensembl)
table1 = table(ids1$affy_hg_u95av2)
sum(table1 > 1)

#Q3
ids2<-getBM(attributes = c( "external_gene_id","affy_hg_u95av2","chromosome_name"),filters = c("affy_hg_u95av2","chromosome_name"), values = list(values,c(1:22)), mart = ensembl)
head(ids2)
table2 = table(ids2$affy_hg_u95av2)
sum(table2 >= 1)

#Q4
library(minfiData)
data(MsetEx)
MsetEx
meth = getMeth(MsetEx[,2])
head(meth)
mean(meth)

#Q5
library(GEOquery)
eList <- getGEO("GSE788")
edata <- eList[[1]]
sampleNames(edata)
mean(exprs(edata[,2]))

#Q6
library(airway)
data(airway)
airway
cdata = colData(airway)
mean(cdata$avgLength)

#Q7
assay = assay(airway, "counts")
colnames(airway)
sum(assay[,3] >= 1)


#Q8
autosome <- paste("chr",c(1:22),sep="")
exon = exons(TxDb.Hsapiens.UCSC.hg19.knownGene)
grangelist = rowRanges(airway)
seqlevelsStyle(grangelist) <- "UCSC"
subexon = keepSeqlevels(exon, c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20","chr21","chr22"))
subgrangelist = keepSeqlevels(grangelist, c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20","chr21","chr22"))
sub = subsetByOverlaps(subgrangelist, subexon)

#Q9
s1grange = rowRanges(airway[,1])
seqlevelsStyle(s1grange) <- "UCSC"
s1grange_sub=keepSeqlevels(s1grange, c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20","chr21","chr22"))
sub1 = subsetByOverlaps(s1grange_sub, subexon)
ovnames = names(sub1)
assay1 = assay[,1]
sum(assay1[ovnames])/sum(assay1)

#Q10
library(rtracklayer)
library(AnnotationHub)
ah <- AnnotationHub()
ah <- subset(ah, species == "Homo sapiens")
qhs = query(ah, c("narrowpeak","E096","H3K4me3"))
H3K4me3 = qhs[[1]]







