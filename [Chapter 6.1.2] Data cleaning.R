df1 = read.csv("data/tweets_raw.csv")
str(df1)

library(stopwords)
# Get the text column
text <- df1$Text
# Set the text to lowercase
text <- tolower(text)
# Remove mentions, urls, emojis, numbers, punctuations, etc.
text <- gsub("@\\w+", "", text)
text <- gsub("https?://.+", "", text)
text <- gsub("\\d+\\w*\\d*", "", text)
text <- gsub("#\\w+", "", text)
text <- gsub("[^\x01-\x7F]", "", text)
text <- gsub("[[:punct:]]", " ", text)

final_stopwords = c(stopwords('en'))
stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
stopwords_regex = paste0('\\b', stopwords_regex, '\\b')
text = stringr::str_replace_all(text, stopwords_regex, '')

# Remove spaces and newlines
text <- gsub("\n", " ", text)
text <- gsub("^\\s+", "", text)
text <- gsub("\\s+$", "", text)
text <- gsub("[ |\t]+", " ", text)

# Put the data to a new column
df1["clean_text"] <- text
df2 = df1[!duplicated(df1$clean_text),]

library(dplyr)
#remove tweets from a user who is spam
df_final = df2 %>% filter(!Username %in% c("lili_eyebags", "DorrisRivero", "MermanLee", "amateurbgamer", "JuiceTales",
                                           "nigel_elijah", "Arti1604Arti", "roselynaris", "oreochiz", "faliqfarhan",
                                           "mafeitz", "501deghie", "teejayanu", "Saniroz", "eddydaud", "adriancheok",
                                           "AuggieAnthuvan", "LeniMarliza__", "rajeevmusic007", "christabel_koh", "argus_metals"))

str(df_final)
dim(df_final) #5267 total tweets
length(unique(df_final$Tweet.User.Id)) #2128 unique users

write.csv(df_final,"data/tweets_final.csv")