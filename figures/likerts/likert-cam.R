### You'll need to:
## install_packages("plyr")
## install.packages("devtools")
## require(devtools)
## install_github('jbryer/likert')
require(likert)
require(plyr)
f <- read.csv("woz-cam.csv", stringsAsFactors=TRUE)
f <- f[, -2]
lvls <- c("Strongly Disagree",
         "Disagree",
         "Neutral",
         "Agree",
         "Strongly Agree")
cols <- c(3:7)
f[cols] <- lapply(f[cols], factor, levels=lvls)
questions <- f[cols]
questions <- rename(questions, c(Participant="Participant",
                                Condition="Condition",
                                I.found.the.camera.useful.="I found the camera useful.",
                                I.knew.what.the.camera.was.looking.at.during.the.meeting.="I knew what the camera was looking at during the meeting.",
                                I.wanted.to.control.the.camera.="I wanted to control the camera.",
                                I.could.control.the.camera.with.ease.="I could control the camera with ease.",
                                I.found.controlling.the.robot.distracting.="I found controlling the robot distracting."))
brewer <- c("#d7191c","#fdae61","#ffffbf","#abd9e9","#2c7bb6")
l <- likert(questions[, 1:2], grouping=f$Condition)
plot(l,
     plot.percents=FALSE,
     plot.percent.high=TRUE,
     plot.percent.low=TRUE,
     plot.percent.neutral=FALSE,
     text.size=2,
     wrap=500,
     color=brewer,
     legend.position="bottom")
ggsave("likert-woz-1.pdf", width=7, height=5)

l <- likert(questions[1:20, 3, drop=FALSE], grouping=f$Condition[1:20])
plot(l,
     plot.percents=FALSE,
     plot.percent.high=TRUE,
     plot.percent.low=TRUE,
     plot.percent.neutral=FALSE,
     text.size=2,
     wrap=500,
     color=brewer,
     legend.position="bottom")
ggsave("likert-woz-2.pdf", width=6, height=2.25)

l <- likert(questions[21:40, 4:5, drop=FALSE], grouping=f$Condition[21:40])
plot(l,
     plot.percents=FALSE,
     plot.percent.high=TRUE,
     plot.percent.low=TRUE,
     plot.percent.neutral=FALSE,
     text.size=2,
     wrap=500,
     color=brewer,
     legend.position="bottom")
ggsave("likert-woz-3.pdf", width=7, height=3.5)
