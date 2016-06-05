#Q1
library(yeastRNASeq)
library(ShortRead)
fastqFilePath <-  system.file("reads", "wt_1_f.fastq.gz", package = "yeastRNASeq")
reads <- readFastq(fastqFilePath)
reads
seq = sread(reads)
pos5 = DNAStringSet(seq, start = 5, end = 5)
head(seq)
head(pos5)
pos5_info = unlist(pos5)
alphabetFrequency(pos5_info)
#Q2
qual = as(quality(reads), "matrix")
mean(qual[,5])
#Q3
library(leeBamViews)
bamFilePath <- system.file("bam", "isowt5_13e.bam", package="leeBamViews")
bamFile <- BamFile(bamFilePath)
gr <- GRanges(seqnames = "Scchr13",ranges = IRanges(start = c(800000), end = c(801000)))
parmas <- ScanBamParam(which = gr, what = scanBamWhat())
aln <- scanBam(bamFile, param = parmas)
pos <- aln$`Scchr13:800000-801000`$pos
single = sum(table(pos)==1)
duplicate = length(pos) - single
#Q4
bpaths <- list.files(system.file("bam", package="leeBamViews"), pattern = "bam$", full=TRUE)
bam1 <- BamFile(bpaths[1])
bam2 <- BamFile(bpaths[2])
bam3 <- BamFile(bpaths[3])
bam4 <- BamFile(bpaths[4]) 
bam5 <- BamFile(bpaths[5])
bam6 <- BamFile(bpaths[6])
bam7 <- BamFile(bpaths[7])
bam8 <- BamFile(bpaths[8])
gr2 <- GRanges(seqnames = "Scchr13",ranges = IRanges(start = c(807762), end = c(808068)))
params <- ScanBamParam(which = gr2, what = scanBamWhat())
aln1 <- scanBam(bam1, param = params)
aln2 <- scanBam(bam2, param = params)
aln3 <- scanBam(bam3, param = params)
aln4 <- scanBam(bam4, param = params)
aln5 <- scanBam(bam5, param = params)
aln6 <- scanBam(bam6, param = params)
aln7 <- scanBam(bam7, param = params)
aln8 <- scanBam(bam8, param = params)
sum = sum(length(aln1$`Scchr13:807762-808068`$seq), length(aln2$`Scchr13:807762-808068`$seq),length(aln3$`Scchr13:807762-808068`$seq),length(aln4$`Scchr13:807762-808068`$seq),length(aln5$`Scchr13:807762-808068`$seq),length(aln6$`Scchr13:807762-808068`$seq),length(aln7$`Scchr13:807762-808068`$seq),length(aln8$`Scchr13:807762-808068`$seq))
sum/8
#Q5
library(GEOquery)
getGEOSuppFiles("GSE38792")
list.files("GSE38792")
untar("GSE38792/GSE38792_RAW.tar", exdir = "GSE38792/CEL")
list.files("GSE38792/CEL")
library(oligo)
celfiles <- list.files("GSE38792/CEL", full = TRUE)
rawData <- read.celfiles(celfiles)
filename <- sampleNames(rawData)
pData(rawData)$filename <- filename
sampleNames <- sub(".*_", "", filename)
sampleNames <- sub(".CEL.gz$", "", sampleNames)
sampleNames(rawData) <- sampleNames
pData(rawData)$group <- ifelse(grepl("^OSA", sampleNames(rawData)),
                               "OSA", "Control")
pData(rawData)
normData <- rma(rawData)
normData
exprsData = exprs(normData)
mean(exprsData["8149273", 1:8])
#Q6
design <- model.matrix(~ normData$group)
fit <- lmFit(ourData, design)
fit <- eBayes(fit)
table = topTable(fit)
min(table$P.Value)
#Q7
table$adj.P.Val < 0.05
#Q8
library(minfi)
library(minfiData)
data("RGsetEx")
RGsetEx
grSet <- preprocessFunnorm(RGsetEx)
grBeta <- getBeta(grSet)
pData <- pData(RGsetEx)
diff1 = abs(grBeta[,4]-grBeta[,5])
diff2 = abs(grBeta[,2]-grBeta[,6])
diff3 = abs(grBeta[,1]-grBeta[,3])
diff = cbind(diff1,diff2,diff3)
#Q9
ah <- AnnotationHub()
ah <- subset(ah, species == "Homo sapiens")
qhs <- query(ah, c("narrowPeak", "hg19", "Caco2", "DNase", "AWG"))







