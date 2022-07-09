library(tidyverse)
vec = songdata$song %>% as.character() %>% c(.)

str1 = missing_songs$songid[300] %>% as.character()

GetCloseMatches(string = str1, sequence_strings = vec, n = 1L, cutoff = 0.7)


missing_songs$artist[300] %>% as.character()

str_remove(str1,missing_songs$artist[300] %>% as.character())

v1 <- 
  
  missing_songs %>% 
  mutate( songid = songid  %>% as.character(),
          artist = artist %>% as.character(),
          song=str_remove(songid,artist )) %>% 
  inner_join(songdata) 




lyrics <- read_csv("lyrics.csv")

v2 <- missing_songs %>% 
  mutate( songid  = songid  %>% as.character(),
          artist1 = artist  %>% as.character(),
          artist  = artist  %>% as.character() %>% tolower() %>% str_replace_all(" ", "-") ,
          song= str_remove(songid,artist1 ) %>% tolower() %>% str_replace_all(" ", "-")  ) %>% 

  inner_join(lyrics,by = c( "song","artist")) %>% 
  select(-artist) %>% rename(artist = artist1)








v1 <- missing_songs %>% 
  mutate( songid  = songid  %>% as.character(),
          artist1 = artist  %>% as.character(),
          artist  = artist  %>% as.character() %>% tolower() %>% str_replace_all(" ", "-") ,
          song= str_remove(songid,artist1 ) %>% tolower() %>% str_replace_all(" ", "-")  ) %>% 
  
  inner_join(lyrics,by = c( "song","artist")) %>% 
  select(-artist,-index) %>% rename(artist = artist1, text= lyrics, year = year.y ) %>% mutate(link=NA) %>% 
  rbind(
    missing_songs %>% 
      mutate( songid = songid  %>% as.character(),
              artist = artist %>% as.character(),
              song=str_remove(songid,artist )) %>% 
      inner_join(songdata) %>% mutate(genre=NA,year.x=NA)
    
  )





v2 <- missing_songs %>% anti_join(v1)
v2 %>% select(songid) %>% distinct() %>% View()
v3 <- read_csv(file="manual.csv")

v2<-v2 %>% anti_join(v3) 

v2 %>% select(songid) %>% distinct() %>% View()


library(genius)

url =  "https://genius.com/Goo-goo-dolls-better-days-lyrics"



genius_lyrics(artist = "Mariah Carey", song = "All I Want For Christmas Is You") %>% str_remove_all("\"")


missing_songs <- missing_songs  %>% 
  mutate( songid = songid  %>% as.character(),
          artist = artist %>% as.character(),
          song=str_remove(songid,artist ) %>% toupper(),
          url = gen_song_url(artist = artist, song = song) )  %>% 
  select("title" = song,
         artist,
         songid,
         weekid) %>% 
  add_genius(artist = artist, title = title) %>% 
  select(-lyrics)






gen_song_url(artist = "Mariah Carey", song = "All I Want For Christmas Is You") %>% 
genius_url(info = "simple")

genius_url(info = "simple")

get_missing_lyrics <- function( raw)
{
   raw["url"] %>% as.character() %>% genius_url() %>% mutate(songid = raw["songid"],
                                                             artist = raw["artist"],
                                                             weekid = raw["weekid"])
 
}

get_missing_lyrics <- function( raw) {
    tryCatch(
      raw["url"] %>% as.character() %>% genius_url() %>% mutate(songid = raw["songid"],
                                                                artist = raw["artist"],
                                                                weekid = raw["weekid"]),
          warning = function(warning) {print(paste("warning:",warning));
             list(track_title="",line=1,lyric="", songid="TOBEREMOVED", weekid="NA")},
          error   = function(error)   {print(paste("error:", error));
            list(track_title="",line=1,lyric="NA", songid="TOBEREMOVED", weekid="")}) 
}


missing_lyrics <- missing_lyrics_songs %>% apply(1,get_missing_lyrics) %>% bind_rows() %>% 
                 filter(songid!="TOBEREMOVED")

 missing_lyrics_songs %>% anti_join(missing_lyrics) %>% View()

missing_lyrics_songs[1,]  %>% genius_url1()




