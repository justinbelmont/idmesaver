class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  attr_accessor :response, :parsed_response, :item, :price, :image, :discount, :converse_w_saved, :converse_w_retail_price, :converse_w_product_image, :converse_w_product_title, :converse_w_student_price, :theory_m_retail_price, :theory_m_product_image, :theory_m_product_title, :theory_m_student_price, :theory_m_saved, :theory_w_retail_price, :theory_w_product_image, :theory_w_product_title, :theory_w_student_price, :theory_w_saved

require 'rest_client'

CONVERSE_DISCOUNT = 0.20
THEORY_DISCOUNT = 0.20
JCREW_DISCOUNT = 0.15
FAHERTY_DISCOUNT = 0.20

def initialize

# GET ALL THE DATA 
  conversemen = RestClient.get 'http://www.kimonolabs.com/api/6wl3jrra?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  conversewomen = RestClient.get 'http://www.kimonolabs.com/api/d5zydwiu?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  
  theorywomen = RestClient.get 'http://www.kimonolabs.com/api/c7ui87gw?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  theorymen = RestClient.get 'http://www.kimonolabs.com/api/4kwjdn8g?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  jcrewwomen = RestClient.get 'http://www.kimonolabs.com/api/4qjzgxmk?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  jcrewmen = RestClient.get 'http://www.kimonolabs.com/api/3hznva6u?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

  fahertywomen = RestClient.get 'http://www.kimonolabs.com/api/4nj9de08?apikey=85bcefb6f51d73a5223de8528c4fb2dc'
  fahertymen = RestClient.get 'http://www.kimonolabs.com/api/8be070ku?apikey=85bcefb6f51d73a5223de8528c4fb2dc'

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

#JCREW
  @parsed_jcrew_w = JSON.parse(jcrewwomen)
  @jcrew_w = @parsed_jcrew_w["results"]

  @parsed_jcrew_m = JSON.parse(jcrewmen)
  @jcrew_m = @parsed_jcrew_m["results"] 

#FAHERTY

  @parsed_faherty_w = JSON.parse(fahertywomen)
  @faherty_w = @parsed_faherty_w["results"]["collection1"]

  @parsed_faherty_m = JSON.parse(fahertymen)
  @faherty_m = @parsed_faherty_m["results"]["collection1"]

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
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i)
end

def theory_m_product_image(item)
  @theory_m[item]["theory-men-imgs"]["src"]
end

def theory_m_product_title(item)
  @theory_m[item]["theory-men-title"]["text"].truncate(45)
end

def theory_m_student_price(item)
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def theory_m_saved(item)
  retail_price = @theory_m[item]["theory-men-price"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end


# WOMEN'S THEORY


def theory_w_retail_price(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  number_to_currency(retail_price.to_i)
end

def theory_w_product_image(item)
  @theory_w[item]["theory-women-imgs"]["src"]
end

def theory_w_product_title(item)
  @theory_w[item]["theory-women-titles"]["text"].truncate(45)
end

def theory_w_student_price(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def theory_w_saved(item)
  retail_price = @theory_w[item]["theory-women-prices"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - THEORY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end

# MENS JCREW

def jcrew_m_retail_price(item)
  @jcrew_m["collection2"][item]["jcrew-mens-prices"]["text"]
end

def jcrew_m_product_image(item)
  @jcrew_m["collection1"][item]["jcrew-mens-imgs"]["src"]
end

def jcrew_m_product_title(item)
  @jcrew_m["collection2"][item]["jcrew-mens-titles"]["text"].truncate(30)
end

def jcrew_m_student_price(item)
  retail_price = @jcrew_m["collection2"][item]["jcrew-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def jcrew_m_saved(item)
  retail_price = @jcrew_m["collection2"][item]["jcrew-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end

# WOMENS JCREW

def jcrew_w_retail_price(item)
  @jcrew_w["collection2"][item]["jcrew-womens-prices"]["text"]
end

def jcrew_w_product_image(item)
  @jcrew_w["collection1"][item]["jcrew-womens-imgs"]["src"]
end

def jcrew_w_product_title(item)
  @jcrew_w["collection2"][item]["jcrew-womens-titles"]["text"].truncate(30)
end

def jcrew_w_student_price(item)
  retail_price = @jcrew_w["collection2"][item]["jcrew-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def jcrew_w_saved(item)
  retail_price = @jcrew_w["collection2"][item]["jcrew-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - JCREW_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end

# WOMEN'S FAHERTY

def faherty_w_retail_price(item)
  @faherty_w[item]["faherty-womens-prices"]["text"]
end

def faherty_w_product_image(item)
  @faherty_w[item]["faherty-womens-imgs"]["src"]
end

def faherty_w_product_title(item)
  @faherty_w[item]["faherty-womens-titles"]["text"].truncate(35)
end

def faherty_w_student_price(item)
  retail_price = @faherty_w[item]["faherty-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def faherty_w_saved(item)
  retail_price = @faherty_w[item]["faherty-womens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end

# MEN'S FAHERTY

def faherty_m_retail_price(item)
  @faherty_m[item]["faherty-mens-prices"]["text"]
end

def faherty_m_product_image(item)
  @faherty_m[item]["faherty-mens-imgs"]["src"]
end

def faherty_m_product_title(item)
  @faherty_m[item]["faherty-mens-titles"]["text"].truncate(35)
end

def faherty_m_student_price(item)
  retail_price = @faherty_m[item]["faherty-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  number_to_currency(student_price.to_i)
end

def faherty_m_saved(item)
  retail_price = @faherty_m[item]["faherty-mens-prices"]["text"].gsub(/[^\d\.]/, '').to_i
  student_price = retail_price * (1 - FAHERTY_DISCOUNT)
  saved = retail_price - student_price
  number_to_currency(saved.to_i)
end

end
