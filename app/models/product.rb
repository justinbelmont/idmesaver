class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessor :response, :parsed_response, :item, :price, :image, :discount, :converse_w_saved, :converse_w_retail_price, :converse_w_product_image, :converse_w_product_title, :converse_w_student_price, :theory_m_retail_price, :theory_m_product_image, :theory_m_product_title, :theory_m_student_price, :theory_m_saved, :theory_w_retail_price, :theory_w_product_image, :theory_w_product_title, :theory_w_student_price, :theory_w_saved

require 'rest_client'

CONVERSE_DISCOUNT = 0.20

def initialize

# GET ALL THE DATA 
  conversemen = RestClient.get 'http://www.kimonolabs.com/api/6wl3jrra?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  conversewomen = RestClient.get 'http://www.kimonolabs.com/api/d5zydwiu?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  theorywomen = RestClient.get 'http://www.kimonolabs.com/api/c7ui87gw?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  theorymen = RestClient.get 'http://www.kimonolabs.com/api/4kwjdn8g?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
#PARSE AND FORMAT ALL THE DATA
#CONVERSE
  @parsed_conversemen = JSON.parse(conversemen)
  @data = @parsed_conversemen["results"]["collection1"]

  @parsed_conversewomen = JSON.parse(conversewomen)
  @dataw = @parsed_conversewomen["results"]["collection1"]

#THEORY
  @parsed_theory_w = JSON.parse(theorywomen)
  @theory_w = @parsed_theory_w["results"]["collection1"]

  @parsed_theory_m = JSON.parse(theorymen)
  @theory_m = @parsed_theory_m["results"]["collection1"]  

end

# MENS CONVERSE

def retail_price(item)
  @data[item]["mens-shoes-prices"]
end

def product_image(item)
  @data[item]["mens-shoes-imgs"]["src"]
end

def product_title(item)
  @data[item]["mens-shoes-imgs"]["alt"].truncate(30)
end

def student_price(item)
  retail_price = @data[item]["mens-shoes-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def saved(item)
  retail_price = @data[item]["mens-shoes-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end


# WOMENS CONVERSE

def converse_w_retail_price(item)
  @dataw[item]["sneakers-prices"]
end

def converse_w_product_image(item)
  @dataw[0]["sneaker-imgs"]["src"]
end

def converse_w_product_title(item)
  @dataw[item]["sneakers-title"]["text"].truncate(30)
end

def converse_w_student_price(item)
  retail_price = @dataw[item]["sneakers-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def converse_w_saved(item)
  retail_price = @dataw[item]["sneakers-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end

# MEN'S THEORY

def theory_m_retail_price(item)
  @theory_m[item]["theory-men-price"]
end

def theory_m_product_image(item)
  @theory_m[item]["theory-men-imgs"]["src"]
end

def theory_m_product_title(item)
  @theory_m[item]["theory-men-title"]["text"].truncate(30)
end

def theory_m_student_price(item)
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def theory_m_saved(item)
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end


# WOMEN'S THEORY


def theory_w_retail_price(item)
  @theory_w[item]["theory-women-prices"]
end

def theory_w_product_image(item)
  @theory_w[item]["theory-women-imgs"]["src"]
end

def theory_w_product_title(item)
  @theory_w[item]["theory-women-titles"]["text"].truncate(35)
end

def theory_w_student_price(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def theory_w_saved(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - CONVERSE_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end

end
