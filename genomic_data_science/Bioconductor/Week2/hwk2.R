#Q1
library(BSgenome)
available.genomes()
library("BSgenome.Hsapiens.UCSC.hg19")
Hsapiens
Hsapiens$chr22
chr22seq = Hsapiens$chr22
chr22alf <- alphabetFrequency(chr22seq)
chr22gc <- sum(chr22alf[c("G","C")])/ sum(chr22alf[c("A","T","C","G")])
chr22gc

#Q2
library(GenomicRanges)
library(rtracklayer)
library(AnnotationHub)
ah <- AnnotationHub()
ah <- subset(ah, species == "Homo sapiens")
qhs = query(ah, "narrowpeak")
qhs = query(qhs, "E003")
qhs = query(qhs, "H3K27me3")
H3K27me3 = qhs[[1]]
HK_chr22 = keepSeqlevels(H3K27me3, "chr22")
HK_chr22_seq = getSeq(Hsapiens, HK_chr22)
HK_chr22_seq_af = alphabetFrequency(HK_chr22_seq,as.prob = TRUE)
gc = HK_chr22_seq_af[,2]+HK_chr22_seq_af[,3]
gcM = mean(gc)
gcM

#Q3
HK_chr22_signalV = HK_chr22$signalValue
cor(gc, HK_chr22_signalV)

#Q4
qhs = query(ah, c("H3K27me3","fc.signal","E003"))
bw = qhs[[1]]
chr22.rle <- import(bw, which = HK_chr22, as = "Rle")
chr22_fc.signal = aggregate(chr22.rle$chr22, HK_chr22, FUN = mean)
cor(HK_chr22_signalV, chr22_fc.signal)

#Q5
gr.chr22 = GRanges(seqnames = "chr22", ranges = IRanges(start = 1, end = 51304566))
rle.allChr = import(bw, which = gr.chr22, as="Rle")
table(rle.allChr$chr22 >= 1)

#Q6
qhs = query(ah, c("H3K27me3","fc.signal","E055"))
bw2 = qhs[[1]]
rle.allChr.055 <- import(bw2, which = gr.chr22, as = "Rle")
reg_1 = slice(rle.allChr[["chr22"]],upper=0.5)
reg_2 = slice(rle.allChr.055[["chr22"]],lower=2)
ir_1 <- as(reg_1, "IRanges")
ir_2 <- as(reg_2, "IRanges")
inter = intersect(ir_1, ir_2)
sum(width(inter))

#Q7
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
subset = subset(transcriptLengths(txdb, with.cds_len = TRUE))
subsub = subset(subset, subs$cds_len >0)
chr22_transcripts = subsetByOverlaps(transcripts(txdb), gr.chr22)
chr22_transcripts_sub = chr22_transcripts[elementMetadata(chr22_transcripts)[,1] %in% subsub$tx_id]
prom = promoters(chr22_transcripts_sub)
rl <- coverage(prom)
reg_trsp = slice(rl[["chr22"]], lower = 2)
sum(width(reg_trsp))

