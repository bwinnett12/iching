
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


# A homemade function for creating csvs (so that it saves lines)
create_csv <- function(csv_current) {

  # File name that can be reused
  file_name <- paste("temp/","csv_",  toString(csv_current), ".csv", sep="")
  file.create(file_name)
  
  # Generates 10000 (A myriad) of numbers that can be written to the text
  numbers <- floor(runif(10000, min=0, max=2))
  write.csv(numbers, file = file_name)
  
}

# A homemade function for creating txts (so that it saves lines)
create_txt <- function(txt_current) {
  
  # File name that can be reused
  file_name <- paste("temp/","txt_",  toString(txt_current), ".txt", sep="")
  file.create(file_name)
  
  # Generates A myriad (10000) of numbers that can be written to the text
  numbers <- floor(runif(10000, min=0, max=2))
  write(numbers, file = file_name)
}


# A homemade function for deleting a random csv (To save lines)
# While it is possible to do this in 2 - 3 lines with a list.files(pattern...)
# I kept it this way to preserve a bit more of randomness
delete_csv <- function() {
  all_files <- list.files("./temp")
  
  # Repeats cycling through until a csv is found
  repeat {  
    doomed_file <- all_files[runif(1, min= 1, max = length(all_files) + 1)]
    if (grepl(".csv", doomed_file, fixed=TRUE)) {
      
      unlink(paste("./temp/", doomed_file, sep = ""))
      break
    }
  }
}

# A homemade function for deleting a random txt (To save lines)
# While it is possible to do this in 2 - 3 lines with a list.files(pattern...)
# I kept it this way to preserve a bit more of randomness
delete_txt <- function() {
  all_files <- list.files("./temp")
  
  # Repeats cycling through until a csv is found
  repeat {  
    doomed_file <- all_files[runif(1, min= 1, max = length(all_files) + 1)]
    if (grepl(".txt", doomed_file, fixed=TRUE)) {
      
      unlink(paste("./temp/", doomed_file, sep = ""))
      break
    }
  }
}



reading <- rep("x", 6)   # This will be your reading once done






# Counts of how many we he have. Also nice for numbering purposes
csv_count <- 0
txt_count <- 0

# For sake of complete randomness and not anarchy, making 150 files
for (x in 1:150) {
  # Generating a random number
  random_number <- runif(1, min=0, max=10)
  
  # TXT case (greater than 5. Generates a text file with 10000 ones and zeros)
  # (Function defined above)
  if (random_number > 5) {
    txt_count = txt_count + 1 
    create_txt(txt_count)
  }
  
  # The CSV case (less than 5). Generates a csv with 10000 1 & zeroes in a
  # Double column  (Function defined above)
  else {
    csv_count = csv_count + 1
    create_csv(csv_count)
  }
}

# The balancing act
# Runs until one of two conditions are met
# 1) One is double the other
# 2) The totals are equal
repeat {
  # Next chunk is resetting counters of whats in the folder
  all_files <- list.files("./temp")
  
  
  # Completion conditions check.... If not... Time for the next round!
  if (csv_count == txt_count 
      || abs(csv_count - txt_count) >= min(csv_count, txt_count)) {
    
    # Prints out which one was victorious
    print(c("csv_count", "txt_count")[which.max(c(csv_count, txt_count))])
    break
  } 
  
  # Cap this whole thing at 5000
  if (length(all_files) >= 5000) {
    print(c("csv_count", "txt_count")[which.min(c(csv_count, txt_count))])
    break
  }
  
  # Randomly select one of the files
  # Case for if a csv was chosen
  if (grepl(".csv", 
            all_files[floor(runif(1, min= 1, max = length(all_files)) + 1)], 
            fixed=TRUE)) {
    
    # If csv is in the lead by 50%
    if ((csv_count - txt_count) >= (min(csv_count, txt_count) * 0.50)) {
      
      # Make 2 csv, make 1 txt
      create_csv(csv_count)
      csv_count = csv_count + 1
      
      create_csv(csv_count)
      csv_count = csv_count + 1
      
      create_txt(txt_count)
      txt_count = txt_count + 1 
    }
    
    # Not in the lead
    else {
      # Make 1 csv, make 2 txt
      create_csv(csv_count)
      csv_count = csv_count + 1
      
      create_txt(txt_count)
      txt_count = txt_count + 1
      
      create_txt(txt_count)
      txt_count = txt_count + 1
    }
    
    
  }
  # Case for if a txt was chosen
  else {
    
    # If txt is in the lead by 50%
    if ((txt_count - csv_count) >= (min(csv_count, txt_count) * 0.50)) {
      # Make 1 txt, make 1 csv
      create_csv(csv_count)
      csv_count = csv_count + 1
      
      create_txt(txt_count)
      txt_count = txt_count + 1
      
    }
    # Not in the lead
    else {
      # Make 1 txt, delete 1 csv
      create_txt(txt_count)
      txt_count = txt_count + 1 
      
      delete_csv()
      csv_count = csv_count - 1
    }
  }
}










# Deletes temp
if (dir.exists("temp")) {
  unlink("temp", recursive=TRUE)
}
