
# Introduction....
# print("Hello! Press anything to throw... ")
# readline(prompt = "")
print("Throwing. This will take a minute ")
setwd("/home/bill/Projects/iching")

# Creates a directory to hold all the files in
if (dir.exists("temp")) {
  unlink("temp", recursive=TRUE)
}
dir.create("temp")

# Counts of how many we he have. Also nice for numbering purposes
csv_count <- 0
txt_count <- 0

# For sake of complete randomoness and not anarchy, making 150 files
for (x in 1:150) {
  # Generating a random number
  random_number <- runif(1, min=0, max=10)
  
  # TXT case (greater than 5. Generates a text file with 10000 ones and zeros)
  if (random_number > 5) {
    
    txt_count = txt_count + 1 
    
    # File name that can be reused
    file_name <- paste("temp/","txt_",  toString(txt_count), ".txt", sep="")
    file.create(file_name)
    
    # Generates 10000 (A myriad) of numbers that can be written to the text
    numbers <- floor(runif(10000, min=0, max=2))
    write(numbers, file = file_name)
  }
  # The CSV case (less than 5). Generates a csv with 10000 1 & zeroes in a
  # Double column
  else {
    
    csv_count = csv_count + 1
    
    # File name that can be reused
    file_name <- paste("temp/","csv_",  toString(csv_count), ".csv", sep="")
    file.create(file_name)
    
    # Generates 10000 (A myriad) of numbers that can be written to the text
    numbers <- floor(runif(10000, min=0, max=2))
    write.csv(numbers, file = file_name)
  }
}



# Deletes temp
if (dir.exists("temp")) {
  unlink("temp", recursive=TRUE)
}
