require 'fileutils'

# TODO
# - Add img for child
# - Set delimiet as a constant

# Config data
NB_PRODUCTS     = 1000
GENERATE_IMG    = true
GENERATE_CSV    = true

# CSV Parameter
GENERATE_CHILD                  = true
GENERATE_CHILD_EVERY_X_PRODUCTS = 3  # Enter the value of X
NUMBER_OF_CHILD                 = 5  # Number of Child generated
IMG_DELIMITER                   = ","

# Source Image
SOURCE_FILE       = "source/img.jpg"
SOURCE_SEC0_FILE  = "source/img_sec0.jpg"
SOURCE_SEC00_FILE = "source/img_sec00.jpg"
SOURCE_CHILD0     = "source/img_child0.jpg"
SOURCE_CHILD00    = "source/img_child00.jpg"
SOURCE_CHILD000   = "source/img_child000.jpg"


#-----------------------------------------------------------------------------------------------------
# Create 'output' directory
if File::directory?("output") == false
  Dir.mkdir("output")
end

#-----------------------------------------------------------------------------------------------------
# Generate the CSV Name

csv_name = "output/" + NB_PRODUCTS.to_s + "_product"

if GENERATE_IMG
  csv_name = csv_name + "_with_image"
end

if GENERATE_CHILD
  csv_name = csv_name + "_with_" +  NUMBER_OF_CHILD.to_s + "_childs_every_" + GENERATE_CHILD_EVERY_X_PRODUCTS.to_s + "_product"
end

csv_name = csv_name + ".csv"

#-----------------------------------------------------------------------------------------------------
if GENERATE_IMG

  for i in 1..NB_PRODUCTS
    dest_file = "output/img#{i}.jpg"
    FileUtils.copy(SOURCE_FILE, dest_file)

    dest_file = "output/img_sec0#{i}.jpg"
    FileUtils.copy(SOURCE_SEC0_FILE, dest_file)

    dest_file = "output/img_sec00#{i}.jpg"
    FileUtils.copy(SOURCE_SEC00_FILE, dest_file)  
  end

  if GENERATE_CHILD
    FileUtils.copy(SOURCE_CHILD0, "output/img_child0.jpg")
    FileUtils.copy(SOURCE_CHILD00, "output/img_child00.jpg")
    FileUtils.copy(SOURCE_CHILD000, "output/img_child000.jpg")
  end

end


#-----------------------------------------------------------------------------------------------------
if GENERATE_CSV

  aFile = File.new(csv_name, "w")
    
    # Write the Header of the CSV file
    aFile.syswrite("ProductId" + IMG_DELIMITER + "ProductName" + IMG_DELIMITER + "Cost" + IMG_DELIMITER + "MAP" + IMG_DELIMITER + "ParentId" + IMG_DELIMITER + "VideoURL" + IMG_DELIMITER + "Color" + IMG_DELIMITER + "Height" + IMG_DELIMITER + "Weight" + IMG_DELIMITER + "ShippingMethod" + IMG_DELIMITER + "ImageName\n")

    for i in 1..NB_PRODUCTS

      # Create the parent
      line = "id#{i}" + IMG_DELIMITER + "Exaust" + IMG_DELIMITER + "499.99" + IMG_DELIMITER + "1.1" + IMG_DELIMITER + "" + IMG_DELIMITER + "http://youtube.com" + IMG_DELIMITER + "Silver" + IMG_DELIMITER + "6.2" + IMG_DELIMITER + "35 lbs" + IMG_DELIMITER + "Truck,img#{i}.jpg" + IMG_DELIMITER + "img_sec0#{i}.jpg" + IMG_DELIMITER + "img_sec00#{i}.jpg\n"
      aFile.syswrite(line)

      if GENERATE_CHILD

        # Create a child for every X product
        if (i % GENERATE_CHILD_EVERY_X_PRODUCTS == 0)
          
          # Create the number of child requested
          for j in 1..NUMBER_OF_CHILD
            line = "idChild#{i}#{j}" + IMG_DELIMITER + "Bracket" + IMG_DELIMITER + "19.99" + IMG_DELIMITER + "1.5" + IMG_DELIMITER + "id#{i}" + IMG_DELIMITER + "http://youtube.com" + IMG_DELIMITER + "Silver" + IMG_DELIMITER + "1.2" + IMG_DELIMITER + "0.2 lbs" + IMG_DELIMITER + "Truck" + IMG_DELIMITER + "img_child0.jpg" + IMG_DELIMITER + "img_child00.jpg" + IMG_DELIMITER + "img_child000.jpg\n"

            aFile.syswrite(line)
          end

        end

      end

    end

  aFile.close

end