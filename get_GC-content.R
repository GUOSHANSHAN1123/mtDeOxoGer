library(stringr)
#############################参考基因组修改为16569#####################################
fa<-read.table("human_mtDNA.fasta",head=T)
new<-0
for(i in 1:dim(fa)[1]-1){
new<-paste(new,fa[i+1,],sep="")
}
fn<-strsplit(new,"")
fnew<-fn[[1]][-1]
length(fnew)
fanew<-fnew[-c(16570:17119)]
length(fanew)
mm<-matrix(0,nrow=length(fanew),ncol=2)
mm[,1]<-1:16569

for(i in 1:length(fanew)){
new<-fanew[i:(i+50)]
dex<-which(new %in% "C" == 1 | new %in% "G" == 1)
mm[i,2]<-length(dex)/length(new)
}
write.table(mm,"C-propotion.xlsx",row.names=F,col.names=F,quote=F,sep="\t")
####################################
fa<-read.table("human_mtDNA.fasta",head=T)
new<-0
for(i in 1:dim(fa)[1]-1){
new<-paste(new,fa[i+1,],sep="")
}
fn<-strsplit(new,"")
fnew<-fn[[1]][-1]
length(fnew)
fanew<-fnew[-c(16570:17119)]
length(fanew)
mm<-matrix(0,nrow=length(fanew),ncol=2)
mm[,1]<-1:16569
for(i in 1:16569){
new<-fanew[i:(i+50)]
dex<-which(new %in% "G" == 1)
mm[i,2]<-length(dex)/length(new)
}
write.table(mm,"G-propotion.xlsx",row.names=F,col.names=F,quote=F,sep="\t")
























